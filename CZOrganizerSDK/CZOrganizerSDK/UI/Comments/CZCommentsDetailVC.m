//
//  CZCommentsDetailVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsDetailVC.h"
#import "CZCommentsDetailTableView.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZMJRefreshHelper.h"
#import "CZProductModel.h"
#import "QSClient.h"
@interface CZCommentsDetailVC ()
@property (nonatomic ,strong)UILabel *titleLab;//标题
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong)UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong) CZCommentsDetailTableView *tableView;
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZCommentsDetailVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView.headerView.cycleScrollView stopTimer];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.headerView.cycleScrollView startTimer];
    [self.tableView.headerView.cycleScrollView adjustWhenControllerViewWillAppera];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
    [self actionMethod];
    [self requestForApiObjectCommentsFindObjectCommentsBySocId];
}
- (void)actionMethod{
    WEAKSELF
    //滚动时设置导航条透明度
    [self.tableView setScrollContentSize:^(CGFloat offsetY) {
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
        [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:alpha];
        weakSelf.titleLab.alpha = alpha;
        weakSelf.titleLab.textColor = [UIColor blackColor];
        if (alpha >0.5) {
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
        }else{
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
        }
        //判断是否改变
//        if (offsetY < 0) {
//            CGRect rect = weakSelf.collectionView.headerView.bgImg.frame;
//            //改变图片的y值和高度即可
//            rect.origin.y = offsetY;
//            rect.size.height = ScreenScale(540)+weakSelf.collectionView.tagListHeight - offsetY;
//            weakSelf.collectionView.headerView.bgImg.frame = rect;
//        }
    }];
    
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForApiObjectCommentsFindObjectCommentsBySocId];
    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiObjectCommentsFindObjectCommentsBySocId];
    }];
    
    [self.tableView setSelectProductBlock:^(CZProductModel * _Nonnull model) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    
    //评价点赞
    [self.tableView setCommentsPraiseBlock:^(NSInteger rowIndex) {
        CZCommentModel *model = weakSelf.tableView.dataArr[rowIndex];
        if ([model.isPraise boolValue]) {
            //已点赞，取消点赞
            [weakSelf requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:model];
        }else{
            //未点赞，进行点赞
            [weakSelf requestForApiObjectCommentsPraiseObjectCommentsPraise:model];
        }
    }];
}
//获取评价详情
- (void)requestForApiObjectCommentsFindObjectCommentsBySocId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsFindObjectCommentsBySocId:self.idStr pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.headerView.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(1340));
                CZCommentModel *model = [CZCommentModel modelWithDict:data[@"myDynamicCommentsVo"]];
                //获取商品信息
                [weakSelf requestForApiProductGetProductDetail:model.objId];
//                model.comment = @"操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功";
                model.commentHeight = [weakSelf getStringHeightWithText:model.comment font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(60)];
                weakSelf.tableView.headerView.model = model;
                CGRect rect = weakSelf.tableView.headerView.frame;
                weakSelf.tableView.headerView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + model.commentHeight);
                NSMutableArray *tempArr = data[@"discussCommentsList"];
                NSMutableArray *replyArr = [NSMutableArray array];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    CZCommentModel *replyModel = [CZCommentModel modelWithDict:obj];
                    replyModel.commentHeight = [weakSelf getStringHeightWithText:replyModel.comment font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(60)];
                    replyModel.level = 1;
                    [replyArr addObject:replyModel];
                    if (replyModel.list.count > 0) {
                        [replyModel.list enumerateObjectsUsingBlock:^(CZCommentModel *  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                            model.commentHeight = [weakSelf getStringHeightWithText:[model.comment stringByAppendingFormat:@"回复%@ ",model.toUserNickName] font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(230)];
                            obj1.level = 2;
                            [replyArr addObject:obj1];
                        }];
                    }
                }];
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:replyArr];
                }else{
                    [weakSelf.tableView.dataArr addObjectsFromArray:replyArr];
                }
                [weakSelf.tableView reloadData];

                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                if (replyArr.count < 20) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            });
        }
    }];
}
//获取商品详情
- (void)requestForApiProductGetProductDetail:(NSString *)productId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductGetProductDetail:productId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                CZProductModel *model = [CZProductModel modelWithDict:data];
                weakSelf.tableView.headerView.productModel = model;
            });
        }
    }];
}

/**
评价点赞
*/
- (void)requestForApiObjectCommentsPraiseObjectCommentsPraise:(CZCommentModel *)model{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsPraiseObjectCommentsPraise:model.socId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                model.isPraise = @(1);
                model.praiseCount = @([model.praiseCount integerValue] + 1);
                [weakSelf.tableView reloadData];
            });
        }
    }];
}
/**
取消评价点赞
*/
- (void)requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:(CZCommentModel *)model{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:model.socId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                model.isPraise = @(0);
                model.praiseCount = @([model.praiseCount integerValue] - 1);
                [weakSelf.tableView reloadData];
            });
        }
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//baise_fanhui@2x  tong_yong_fan_hui
    [self.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //右边按钮
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor clearColor];
    self.titleLab.text = @"评价详情";
    [self.navigationItem setTitleView:self.titleLab];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}


- (CZCommentsDetailTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZCommentsDetailTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (void)rbackItemClick{
    
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
