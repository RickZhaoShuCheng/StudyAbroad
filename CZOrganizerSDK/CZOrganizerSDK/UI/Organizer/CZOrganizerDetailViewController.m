//
//  CZOrganizerDetailViewController.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailViewController.h"
#import "CZCommentsListVC.h"

@interface CZOrganizerDetailViewController ()
@property (nonatomic ,strong)UIButton *chatBtn;//咨询按钮
@end

@implementation CZOrganizerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    WEAKSELF
    //将collectionView滚动值传至主控制器
    [self.collectionView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
    }];
    
    //点击全部事件处理
    [self.collectionView setClickAllBlock:^(NSInteger index) {
        if (index == 1) {
            //为您推荐
        }else if (index == 2){
            //顾问团队
        }else if (index == 3){
            //精华日记
        }else if (index == 4){
            //优秀评价
            CZCommentsListVC *commentsList = [[CZCommentsListVC alloc]init];
            [weakSelf.navigationController pushViewController:commentsList animated:YES];
        }
    }];
    
    //测试评价图片
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:@"http://pic1.win4000.com/wallpaper/c/57ad6e8f410eb.jpg"];
    [tempArr addObject:@"http://up.enterdesk.com/edpic/c3/84/b0/c384b0e8f05432c78c72f8d0cd1ab9ac.jpg"];
    [dic setValue:tempArr forKey:@"pics"];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr1 = [NSMutableArray array];
    [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
    [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
    [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
    [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
    [dic1 setValue:tempArr1 forKey:@"pics"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr2 = [NSMutableArray array];
    [dic2 setValue:tempArr2 forKey:@"pics"];
               
    [weakSelf.collectionView.evaluateArr addObject:dic];
    [weakSelf.collectionView.evaluateArr addObject:dic1];
    [weakSelf.collectionView.evaluateArr addObject:dic2];
    [weakSelf.collectionView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.collectionView.headerView.scrollDynamic stopTimer];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collectionView.headerView.scrollDynamic startTimer];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView.headerView.scrollDynamic adjustWhenControllerViewWillAppera];
}
/**
 加载UI
 */
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (CZOrganizerDetailCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[CZOrganizerDetailCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
@end
