//
//  CZAdvisorDetailCollectionView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailCollectionView.h"
#import "CZAdvisorDetailServiceCell.h"
#import "CZAdvisorDetailDiaryCell.h"
#import "CZAdvisorDetailEvaluateCell.h"

@interface CZAdvisorDetailCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CZAdvisorDetailCollectionView

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
        [self registerClass:[CZAdvisorDetailEvaluateCell class] forCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailEvaluateCell class])];
        [self registerClass:[CZAdvisorDetailServiceCell class] forCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailServiceCell class])];
        [self registerClass:[CZAdvisorDetailDiaryCell class] forCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailDiaryCell class])];
        
        [self registerClass:[CZAdvisorDetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZAdvisorDetailHeaderView class])];

        [self registerClass:[CZAdvisorDetailCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZAdvisorDetailCollectionHeadView class])];
        [self registerClass:[CZAdvisorDetailCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CZAdvisorDetailCollectionFooterView class])];
    }
    return self;
}

- (void)setModel:(CZAdvisorInfoModel *)model{
    _model = model;
    self.headerView.model = _model;
    CGRect frame = self.headerView.bgImg.frame;
    CGFloat maxY = self.headerView.tagList.frame.origin.y + self.headerView.tagList.frame.size.height;
    if (maxY >= self.headerView.bgImg.frame.size.height) {
        frame.size.height = frame.size.height + self.headerView.tagList.contentHeight;
        self.tagListHeight = self.headerView.tagList.contentHeight;
        self.headerView.bgImg.frame = frame;
    }
    
    NSMutableArray *filterDiaryArr = [NSMutableArray array];
    if (model.filterDiary.length) {
        [filterDiaryArr addObjectsFromArray:[model.filterDiary componentsSeparatedByString:@","]];
    }
    [self.diaryFilterArr removeAllObjects];
    [self.diaryFilterArr addObjectsFromArray:filterDiaryArr];
    
    NSMutableArray *filterCommentArr = [NSMutableArray array];
    if (model.filterComment.length) {
        [filterCommentArr addObjectsFromArray:[model.filterComment componentsSeparatedByString:@","]];
    }
    [self.evaluateFilterArr removeAllObjects];
    [self.evaluateFilterArr addObjectsFromArray:filterCommentArr];
    
    [self reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1 || section == 2){
        return 4;
    }else{
        if (self.evaluateArr.count >2) {
            return 2;
        }
        return self.evaluateArr.count;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CZAdvisorDetailServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailServiceCell class]) forIndexPath:indexPath];
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
        CZAdvisorDetailDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailDiaryCell class]) forIndexPath:indexPath];
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
    CZAdvisorDetailEvaluateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailEvaluateCell class]) forIndexPath:indexPath];
    cell.picsArr = [self.evaluateArr[indexPath.row] objectForKey:@"pics"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth/2.0, HeightRatio(460));
    }else if (indexPath.section == 2){
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
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(920)+self.tagListHeight);
    }else if (section == 2){
        if (self.diaryFilterArr.count > 0) {
            return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92)+ self.diaryHeader.tagList.contentHeight) ;
        }else{
            return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, HeightRatio(92)) ;
        }
    }else if (section == 3){
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
    if (section == 0) {
        return CGSizeZero;
    }else{
        return CGSizeMake(kScreenWidth, HeightRatio(98));
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CZAdvisorDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZAdvisorDetailCollectionHeadView class]) forIndexPath:indexPath];
        if (indexPath.section == 0) {
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZAdvisorDetailHeaderView class]) forIndexPath:indexPath];
            
            
            return self.headerView;
        }else if (indexPath.section == 1){
            self.projectHeader = header;
            self.projectHeader.titleStr = @"服务项目";
            self.projectHeader.tagList.hidden = YES;
            return self.projectHeader;
        }else if (indexPath.section == 2){
            self.diaryHeader = header;
            self.diaryHeader.titleStr = @"精华日记";
            [self.diaryHeader setTags:self.diaryFilterArr];
            return self.diaryHeader;
        }else{
            self.evaluateHeader = header;
            self.evaluateHeader.titleStr = @"优秀评价";
            [self.evaluateHeader setTags:self.evaluateFilterArr];
            return self.evaluateHeader;
        }
    }else{
        CZAdvisorDetailCollectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CZAdvisorDetailCollectionFooterView class]) forIndexPath:indexPath];
        if (indexPath.section == 0) {
            return nil;
        }else if (indexPath.section == 1){
            self.projectFooter = footer;
            self.projectFooter.titleStr = @"查看全部20个商品";
            self.projectFooter.backgroundColor = CZColorCreater(245, 245, 249, 1);
            self.projectFooter.lineView.hidden = YES;
            return self.projectFooter;
        }else if (indexPath.section == 2){
            self.diaryFooter = footer;
            self.diaryFooter.titleStr = @"查看全部日记";
            self.diaryFooter.backgroundColor = CZColorCreater(255, 255, 255, 1);
            self.diaryFooter.lineView.hidden = NO;
            return self.diaryFooter;
        }else{
            self.evaluateFooter = footer;
            self.evaluateFooter.titleStr = @"查看全部评价";
            self.evaluateFooter.backgroundColor = CZColorCreater(255, 255, 255, 1);
            self.evaluateFooter.lineView.hidden = YES;
            return self.evaluateFooter;
        }
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
