//
//  CZOrganizerProjectCollectionView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerProjectCollectionView.h"
#import "CZOrganizerDetailServiceCell.h"

@interface CZOrganizerProjectCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CZOrganizerProjectCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZOrganizerDetailServiceCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailServiceCell class])];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerDetailServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailServiceCell class]) forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        [cell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(cell.contentView.mas_leading).offset(ScreenScale(30));
        }];
    }else{
        [cell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(cell.contentView.mas_leading).offset(ScreenScale(15));
        }];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/2.0, ScreenScale(560));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
