//
//  CZOrganizerSearchCollectionView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerSearchCollectionView.h"
#import "CZOrganizerSearchCell.h"

@interface CZOrganizerSearchCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CZOrganizerSearchCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceVertical = YES;
        [self registerClass:[CZOrganizerSearchCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerSearchCell class])];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerSearchCell class]) forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(30), ScreenScale(10), kScreenWidth-ScreenScale(30), ScreenScale(46))];
        titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(28)];
        titleLab.text = @"本机构推荐";
        titleLab.textColor = CZColorCreater(0, 0, 0, 1);
        [headerView addSubview:titleLab];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, ScreenScale(56));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/4, ScreenScale(124));
}

- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(ScreenScale(20), 0, ScreenScale(30), 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return ScreenScale(30);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
