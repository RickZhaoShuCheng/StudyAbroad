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
@property (nonatomic ,assign) CGFloat alpha;
@property (nonatomic ,strong) UIView *bottomView;
@property (nonatomic ,strong) UIButton *praiseBtn;
@property (nonatomic ,strong) UILabel *praiseLab;
@property (nonatomic ,strong) UIButton *commentBtn;
@property (nonatomic ,strong) UILabel *commentLab;
@end

@implementation CZCommentsDetailVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView.headerView.cycleScrollView stopTimer];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView.headerView.cycleScrollView startTimer];
    [self.tableView.headerView.cycleScrollView adjustWhenControllerViewWillAppera];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    self.titleLab.alpha = self.alpha;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    self.titleLab.alpha = self.alpha;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0;
    self.pageNum = 1;
    [self initWithUI];
    [self actionMethod];
    [self requestForApiObjectCommentsFindObjectCommentsBySocId];
}
- (void)actionMethod{
    WEAKSELF
    //滚动时设置导航条透明度
    [self.tableView setScrollContentSize:^(CGFloat offsetY) {
        
        NSMutableArray *imgsArr = [NSMutableArray array];
        NSMutableArray *imgUrlArr = [NSMutableArray array];
        if (weakSelf.tableView.model.imgs.length) {
            [imgsArr addObjectsFromArray:[weakSelf.tableView.model.imgs componentsSeparatedByString:@","]];
        }
        [imgsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imgUrlArr addObject:PIC_URL(obj)];
        }];
        if (imgsArr.count <= 0) {
            return;
        }
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
        weakSelf.alpha = alpha;
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
    
//    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
//        weakSelf.pageNum = 1;
//        [weakSelf requestForApiObjectCommentsFindObjectCommentsBySocId];
//    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiObjectCommentsFindObjectCommentsBySocId];
    }];
    
    [self.tableView setSelectProductBlock:^(CZProductModel * _Nonnull model) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    
    //评价点赞
    [self.tableView setCommentsPraiseBlock:^(NSInteger rowIndex,UIButton *likeBtn) {
        CZCommentModel *model = weakSelf.tableView.dataArr[rowIndex];
        if (likeBtn.isSelected) {
            return;
        }
        likeBtn.selected = YES;
        if ([model.isPraise boolValue]) {
            //已点赞，取消点赞
            [weakSelf requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:model actionBtn:likeBtn];
        }else{
            //未点赞，进行点赞
            [weakSelf requestForApiObjectCommentsPraiseObjectCommentsPraise:model actionBtn:likeBtn];
        }
    }];
}
//底部点赞
- (void)clickPraiseBtn{
    if (self.praiseBtn.isSelected) {
        return;
    }
    self.praiseBtn.selected = YES;
    if ([self.tableView.model.isPraise boolValue]) {
        //已点赞，取消点赞
        [self requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:self.tableView.model actionBtn:self.praiseBtn];
    }else{
        //未点赞，进行点赞
        [self requestForApiObjectCommentsPraiseObjectCommentsPraise:self.tableView.model actionBtn:self.praiseBtn];
    }
}

//获取评价详情
- (void)requestForApiObjectCommentsFindObjectCommentsBySocId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsFindObjectCommentsBySocId:self.idStr pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                CZCommentModel *model = [CZCommentModel modelWithDict:data[@"myDynamicCommentsVo"]];
                //获取商品信息
                [weakSelf requestForApiProductGetProductDetail:model.objId];
                if ([model.isPraise boolValue]) {
                    [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateNormal];
                    [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateDisabled];
                }else{
                    [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateNormal];
                    [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateDisabled];
                }
                weakSelf.praiseLab.text = [NSString stringWithFormat:@"%@",[@([model.praiseCount integerValue]) stringValue]];
                weakSelf.commentLab.text = [NSString stringWithFormat:@"%@",[@([model.commentsCount integerValue]) stringValue]];
//                model.comment = @"操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功操作成功";
                model.commentHeight = [weakSelf getStringHeightWithText:model.comment font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(60)];
                weakSelf.tableView.model = model;
                NSMutableArray *imgsArr = [NSMutableArray array];
                NSMutableArray *imgUrlArr = [NSMutableArray array];
                if (model.imgs.length) {
                    [imgsArr addObjectsFromArray:[model.imgs componentsSeparatedByString:@","]];
                }
                [imgsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [imgUrlArr addObject:PIC_URL(obj)];
                }];
                if (imgsArr.count <= 0) {
                    weakSelf.alpha = 1;
                    [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:1];
                    weakSelf.titleLab.alpha = 1;
                    weakSelf.titleLab.textColor = [UIColor blackColor];
                    [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
                    [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
                }
                
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
- (void)requestForApiObjectCommentsPraiseObjectCommentsPraise:(CZCommentModel *)model actionBtn:(UIButton *)actionBtn{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsPraiseObjectCommentsPraise:model.socId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                actionBtn.selected = NO;
                model.isPraise = @(1);
                model.praiseCount = @([model.praiseCount integerValue] + 1);
                if (actionBtn != weakSelf.praiseBtn) {
                    [weakSelf.tableView reloadData];
                }else{
                    if ([model.isPraise boolValue]) {
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateNormal];
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateDisabled];
                    }else{
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateNormal];
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateDisabled];
                    }
                    weakSelf.praiseLab.text = [NSString stringWithFormat:@"%@",[@([model.praiseCount integerValue]) stringValue]];
                    weakSelf.commentLab.text = [NSString stringWithFormat:@"%@",[@([model.commentsCount integerValue]) stringValue]];
                }
            });
        }
    }];
}
/**
取消评价点赞
*/
- (void)requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:(CZCommentModel *)model actionBtn:(UIButton *)actionBtn{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:model.socId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                actionBtn.selected = NO;
                model.isPraise = @(0);
                model.praiseCount = @([model.praiseCount integerValue] - 1);
                if (actionBtn != weakSelf.praiseBtn) {
                    [weakSelf.tableView reloadData];
                }else{
                    if ([model.isPraise boolValue]) {
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateNormal];
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateDisabled];
                    }else{
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateNormal];
                        [weakSelf.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateDisabled];
                    }
                    weakSelf.praiseLab.text = [NSString stringWithFormat:@"%@",[@([model.praiseCount integerValue]) stringValue]];
                    weakSelf.commentLab.text = [NSString stringWithFormat:@"%@",[@([model.commentsCount integerValue]) stringValue]];
                }
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
//    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
//    [self.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
//    [self.shareBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
//    self.navigationItem.rightBarButtonItem = rbackItem;
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
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        if (IPHONE_X) {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kBottomSafeHeight);
        }else{
            make.bottom.mas_equalTo(self.view);
        }
        make.height.mas_equalTo(ScreenScale(94));
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(241, 241, 241, 1);
    line.text = @"";
    [self.bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(1));
    }];

    self.praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateNormal];//zhu_ye_yi_zan
    [self.praiseBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateDisabled];
    [self.praiseBtn addTarget:self action:@selector(clickPraiseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.praiseBtn];
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(60));
        make.height.mas_equalTo(ScreenScale(60));
        make.centerY.mas_equalTo(self.bottomView);
        make.leading.mas_equalTo(self.bottomView.mas_leading).offset(ScreenScale(152));
    }];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:[CZImageProvider imageNamed:@"guwen_pinglun"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[CZImageProvider imageNamed:@"guwen_pinglun"] forState:UIControlStateDisabled];
    [self.bottomView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(60));
        make.height.mas_equalTo(ScreenScale(60));
        make.centerY.mas_equalTo(self.bottomView);
        make.trailing.mas_equalTo(self.bottomView.mas_trailing).offset(-ScreenScale(175));
    }];
    
    self.praiseLab = [[UILabel alloc]init];
    self.praiseLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.praiseLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.praiseLab.text = @"-";
    [self.bottomView addSubview:self.praiseLab];
    [self.praiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.praiseBtn.mas_trailing);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.commentBtn.mas_leading);
        make.centerY.mas_equalTo(self.praiseBtn);
    }];
    
    self.commentLab = [[UILabel alloc]init];
    self.commentLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.commentLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.commentLab.text = @"-";
    [self.bottomView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.commentBtn.mas_trailing);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.bottomView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.commentBtn);
    }];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
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

//- (void)rbackItemClick{
//
//}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
