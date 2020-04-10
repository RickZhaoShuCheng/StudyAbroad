//
//  SchoolStarShopCaseCollectionView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/10.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopCaseCollectionView.h"
#import "CZOrganizerDetailDiaryCell.h"
@interface SchoolStarShopCaseCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation SchoolStarShopCaseCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZOrganizerDetailDiaryCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class])];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerDetailDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class]) forIndexPath:indexPath];
    cell.caseModel = self.dataArr[indexPath.row];
    if (indexPath.row % 2 == 0) {
        [cell.iconImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(cell.contentView.mas_leading).offset(ScreenScale(30));
        }];
    }else{
        [cell.iconImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(cell.contentView.mas_leading).offset(ScreenScale(15));
        }];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/2.0, ScreenScale(690));
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectCaseBlock) {
        self.selectCaseBlock(self.dataArr[indexPath.row]);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

@end
