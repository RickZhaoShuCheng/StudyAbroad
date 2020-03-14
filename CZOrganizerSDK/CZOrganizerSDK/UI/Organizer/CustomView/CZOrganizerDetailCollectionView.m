//
//  CZOrganizerDetailCollectionView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailCollectionView.h"
#import "CZOrganizerDetailEvaluateCell.h"
#import "CZOrganizerDetailServiceCell.h"
#import "CZOrganizerDetailDiaryCell.h"
#import "CZOrganizerDetailAdvisorCell.h"
@interface CZOrganizerDetailCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CZOrganizerDetailCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.tagListHeight = 0.0;
        self.diaryFilterArr = [NSMutableArray array];
        self.evaluateFilterArr = [NSMutableArray array];
        self.evaluateArr = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZOrganizerDetailEvaluateCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailEvaluateCell class])];
        [self registerClass:[CZOrganizerDetailServiceCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailServiceCell class])];
        [self registerClass:[CZOrganizerDetailDiaryCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class])];
        
        [self registerClass:[CZOrganizerDetailAdvisorCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailAdvisorCell class])];
        
        [self registerClass:[CZOrganizerDetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDetailHeaderView class])];

        [self registerClass:[CZOrganizerDetailCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDetailCollectionHeadView class])];
        [self registerClass:[CZOrganizerDetailCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CZOrganizerDetailCollectionFooterView class])];
    }
    return self;
}

- (void)setModel:(CZOrganizerModel *)model{
    _model = model;
    self.headerView.model = model;
    
    CGRect frame = self.headerView.bgImg.frame;
    CGFloat maxY = self.headerView.tagList.frame.origin.y + self.headerView.tagList.frame.size.height;
    if (maxY >= self.headerView.bgImg.frame.size.height) {
        frame.size.height = frame.size.height + self.headerView.tagList.contentHeight;
        self.tagListHeight = self.headerView.tagList.contentHeight;
        self.headerView.bgImg.frame = frame;
    }
    
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 2){
        return 1;
    }else if (section == 1 || section == 3){
        return 4;
    }else{
        if (self.evaluateArr.count >2) {
            return 2;
        }
        return self.evaluateArr.count;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CZOrganizerDetailServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailServiceCell class]) forIndexPath:indexPath];
        if (indexPath.row % 2 == 0) {
            [cell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(cell.contentView.mas_leading).offset(WidthRatio(30));
            }];
        }else{
            [cell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(cell.contentView.mas_leading).offset(WidthRatio(15));
            }];
        }
        return cell;
    }else if (indexPath.section == 2){
        CZOrganizerDetailAdvisorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailAdvisorCell class]) forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 3){
        CZOrganizerDetailDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class]) forIndexPath:indexPath];
        if (indexPath.row % 2 == 0) {
            [cell.iconImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(cell.contentView.mas_leading).offset(WidthRatio(30));
            }];
        }else{
            [cell.iconImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(cell.contentView.mas_leading).offset(WidthRatio(15));
            }];
        }
        return cell;
    }
    CZOrganizerDetailEvaluateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailEvaluateCell class]) forIndexPath:indexPath];
    cell.picsArr = [self.evaluateArr[indexPath.row] objectForKey:@"pics"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth/2.0, HeightRatio(460));
    }else if (indexPath.section == 2){
        return CGSizeMake(kScreenWidth, HeightRatio(280));
    }else if (indexPath.section == 3){
        return CGSizeMake(kScreenWidth/2.0, HeightRatio(660));
    }
#warning 图片高度没算，最多支持6张图片，有机会再优化，缺少内容高度，需动态计算
    if ([[self.evaluateArr[indexPath.row] objectForKey:@"pics"] count] == 0) {
        //无图片
        return CGSizeMake(kScreenWidth, HeightRatio(300));
    }else if ([[self.evaluateArr[indexPath.row] objectForKey:@"pics"] count] <= 3) {
        //1-3张
        return CGSizeMake(kScreenWidth, HeightRatio(480));
    }else{
        //4-6张
        return CGSizeMake(kScreenWidth, HeightRatio(650));
    }
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

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size;
    if (section == 0) {
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(932)+self.tagListHeight);
    }else if (section == 3){
        if (self.diaryFilterArr.count > 0) {
            return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92)+ self.diaryHeader.tagList.contentHeight) ;
        }else{
            return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92)) ;
        }
    }else if (section == 4){
        if (self.evaluateFilterArr.count > 0) {
            return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92) + self.evaluateHeader.tagList.contentHeight);
        }else{
            return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92));
        }
    }else{
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92));
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return CGSizeZero;
    }else{
        return CGSizeMake(kScreenWidth, HeightRatio(98));
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CZOrganizerDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDetailCollectionHeadView class]) forIndexPath:indexPath];
        WEAKSELF
        header.allBtnBlock = ^{
            if (weakSelf.clickAllBlock) {
                weakSelf.clickAllBlock(indexPath.section);
            }
        };
        if (indexPath.section == 0) {
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDetailHeaderView class]) forIndexPath:indexPath];
            return self.headerView;
        }else if (indexPath.section == 1){
            header.titleStr = @"为您推荐";
            header.contentStr = @"查看全部";
            header.tagList.hidden = YES;
        }else if (indexPath.section == 2){
            header.titleStr = @"顾问团队";
            header.contentStr = @"共4个顾问";
            header.tagList.hidden = YES;
        }else if (indexPath.section == 3){
            self.diaryHeader = header;
            self.diaryHeader.titleStr = @"精华日记";
            self.diaryHeader.contentStr = @"全部";
            [self.diaryHeader setTags:self.diaryFilterArr];
            return self.diaryHeader;
        }else{
            self.evaluateHeader = header;
            self.evaluateHeader.titleStr = @"优秀评价";
            self.evaluateHeader.contentStr = @"全部";
            [self.evaluateHeader setTags:self.evaluateFilterArr];
            return self.evaluateHeader;
        }
        return header;
    }else{
        CZOrganizerDetailCollectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CZOrganizerDetailCollectionFooterView class]) forIndexPath:indexPath];
        WEAKSELF
        [footer setAllBtnBlock:^{
            if (weakSelf.clickAllBlock) {
                weakSelf.clickAllBlock(indexPath.section);
            }
        }];
        if (indexPath.section == 0 || indexPath.section == 2) {
            return nil;
        }else if (indexPath.section == 1){
            footer.titleStr = @"查看全部20个商品";
            footer.backgroundColor = CZColorCreater(245, 245, 249, 1);
            footer.lineView.hidden = YES;
        }else if (indexPath.section == 3){
            footer.titleStr = @"查看全部日记";
            footer.backgroundColor = CZColorCreater(255, 255, 255, 1);
            footer.lineView.hidden = NO;
        }else{
            footer.titleStr = @"查看全部评价";
            footer.backgroundColor = CZColorCreater(255, 255, 255, 1);
            footer.lineView.hidden = YES;
        }
        return footer;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

@end
