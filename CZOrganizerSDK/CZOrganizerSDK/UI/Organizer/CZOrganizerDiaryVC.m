//
//  CZOrganizerDiaryVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDiaryVC.h"
#import "CZOrganizerDiaryCollectionView.h"
#import "CZMJRefreshHelper.h"

@interface CZOrganizerDiaryVC ()
@property (nonatomic ,strong) CZOrganizerDiaryCollectionView *collectionView;
@end

@implementation CZOrganizerDiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    WEAKSELF
    __block int i = 0;
    self.collectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        [weakSelf.collectionView.mj_header endRefreshing];
        if (i == 0) {
            NSMutableArray *tagesArr = [NSMutableArray array];
            [tagesArr addObject:@"全部"];
            [tagesArr addObject:@"最新"];
            [tagesArr addObject:@"好评 50"];
            [tagesArr addObject:@"消费后评价 38"];
            [tagesArr addObject:@"消费评价 38"];
            [tagesArr addObject:@"消费后价 38"];
            [tagesArr addObject:@"消后评价 38"];
            [tagesArr addObject:@"差评 50"];
            [weakSelf.collectionView setTagListTags:tagesArr];
            i++;
        }
    }];
    self.collectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
    }];
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (CZOrganizerDiaryCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[CZOrganizerDiaryCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

@end
