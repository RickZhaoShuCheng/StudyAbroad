//
//  SchoolStarShopCaseVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopCaseVC.h"
#import "CZProductVoListModel.h"
@interface SchoolStarShopCaseVC ()

@end

@implementation SchoolStarShopCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
//    [self actionMethod];
    CZProductVoListModel *model = [[CZProductVoListModel alloc]init];
    NSArray *tempArr = @[model,model,model,model,model,model];
    [self.collectionView.dataArr addObjectsFromArray:tempArr];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
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
