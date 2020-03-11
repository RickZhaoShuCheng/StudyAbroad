//
//  CZOrganizerProjectVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerProjectVC.h"
#import "CZOrganizerProjectCollectionView.h"
#import "CZMJRefreshHelper.h"

@interface CZOrganizerProjectVC ()
@property (nonatomic ,strong) CZOrganizerProjectCollectionView *collectionView;
@end

@implementation CZOrganizerProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    WEAKSELF
    self.collectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    self.collectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
    }];
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (CZOrganizerProjectCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[CZOrganizerProjectCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
@end
