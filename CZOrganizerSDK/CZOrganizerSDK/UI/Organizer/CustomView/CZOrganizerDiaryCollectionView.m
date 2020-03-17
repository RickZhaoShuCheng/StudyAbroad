//
//  CZOrganizerDiaryCollectionView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDiaryCollectionView.h"
#import "CZOrganizerDetailDiaryCell.h"

@interface CZOrganizerDiaryCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,assign) BOOL isOpen;
@end
@implementation CZOrganizerDiaryCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.isOpen = NO;
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZOrganizerDetailDiaryCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class])];
        [self registerClass:[CZOrganizerDiaryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDiaryHeaderView class])];
    }
    return self;
}

- (void)setTagListTags:(NSMutableArray *)tagsArr{
 
    if (tagsArr.count > 0) {
        if (self.headerView.tagList.selectedTags.count <= 0) {
            [self.headerView.tagList.selectedTags addObject:tagsArr[0]];
        }
        self.headerView.tagList.tags = tagsArr;
        if (self.headerView.tagList.contentHeight >= ScreenScale(140)) {
            self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(30), kScreenWidth-ScreenScale(60), ScreenScale(140));
            [self.headerView.arrowBtn setHidden:NO];
        }else{
            self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(30), kScreenWidth-ScreenScale(60), self.headerView.tagList.contentHeight);
            [self.headerView.arrowBtn setHidden:YES];
        }
        
        [self reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerDetailDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class]) forIndexPath:indexPath];
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (!self.headerView || self.headerView.tagList.contentHeight == 0) {
        return CGSizeMake(kScreenWidth,0.01);
    }
    if (self.headerView.tagList.contentHeight >= ScreenScale(140)) {
        if (self.isOpen) {
            return CGSizeMake(kScreenWidth, self.headerView.tagList.contentHeight + ScreenScale(80));
        }
        return CGSizeMake(kScreenWidth, ScreenScale(140) + ScreenScale(90));
    }
    return CGSizeMake(kScreenWidth, self.headerView.tagList.contentHeight + ScreenScale(40));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDiaryHeaderView class]) forIndexPath:indexPath];
        [self.headerView.arrowBtn addTarget:self action:@selector(openFilter:) forControlEvents:UIControlEventTouchUpInside];
        return self.headerView;
    }
    return nil;
}

- (void)openFilter:(UIButton *)button{
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        //逆时针 旋转180度
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2]; //动画时长
        button.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
        CGAffineTransform transform = button.transform;
        //第二个值表示横向放大的倍数，第三个值表示纵向缩小的程度
        transform = CGAffineTransformScale(transform, 1,1);
        button.transform = transform;
        [UIView commitAnimations];
    }else{
        //顺时针 旋转180度
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2]; //动画时长
        button.transform = CGAffineTransformMakeRotation(0*M_PI/180);
        CGAffineTransform transform = button.transform;
        transform = CGAffineTransformScale(transform, 1,1);
        button.transform = transform;
        [UIView commitAnimations];
    }
    if (self.isOpen) {
        self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(30), kScreenWidth-ScreenScale(60), self.headerView.tagList.contentHeight);
    }else{
        self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(30), kScreenWidth-ScreenScale(60), ScreenScale(140));
    }
    [self reloadData];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
    if (self.headerView.tagList.contentHeight >= ScreenScale(140)) {
        if (self.isOpen) {
            sectionHeaderHeight = self.headerView.tagList.contentHeight + ScreenScale(80);
        }else{
            sectionHeaderHeight = ScreenScale(140) + ScreenScale(90);
        }
    }else{
        sectionHeaderHeight = self.headerView.tagList.contentHeight + ScreenScale(40);
    }
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
@end
