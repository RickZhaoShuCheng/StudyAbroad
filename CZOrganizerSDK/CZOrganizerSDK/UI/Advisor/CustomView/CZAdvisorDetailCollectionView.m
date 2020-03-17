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
                make.leading.mas_equalTo(cell.contentView.mas_leading).offset(ScreenScale(30));
            }];
        }else{
            [cell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(cell.contentView.mas_leading).offset(ScreenScale(15));
            }];
        }
        return cell;
    }else if (indexPath.section == 2){
        CZAdvisorDetailDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailDiaryCell class]) forIndexPath:indexPath];
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
    CZAdvisorDetailEvaluateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailEvaluateCell class]) forIndexPath:indexPath];
    cell.picsArr = [self.evaluateArr[indexPath.row] objectForKey:@"pics"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth/2.0, ScreenScale(560));
    }else if (indexPath.section == 2){
        return CGSizeMake(kScreenWidth/2.0, ScreenScale(690));
    }
#warning 图片高度没算，最多支持6张图片，有机会再优化，缺少内容高度，需动态计算
    if ([[self.evaluateArr[indexPath.row] objectForKey:@"pics"] count] == 0) {
        //无图片
        return CGSizeMake(kScreenWidth, ScreenScale(330));
    }else if ([[self.evaluateArr[indexPath.row] objectForKey:@"pics"] count] <= 3) {
        //1-3张
        return CGSizeMake(kScreenWidth, ScreenScale(550));
    }else{
        //4-6张
        return CGSizeMake(kScreenWidth, ScreenScale(750));
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
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(920)+self.tagListHeight);
    }else if (section == 2){
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(100)+ [self getSectionHeaderHeight:self.diaryFilterArr]) ;
    }else if (section == 3){
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(100) + [self getSectionHeaderHeight:self.evaluateFilterArr]);
    }else{
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(100));
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }else{
        return CGSizeMake(kScreenWidth, ScreenScale(130));
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CZAdvisorDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZAdvisorDetailCollectionHeadView class]) forIndexPath:indexPath];
        WEAKSELF
        header.allBtnBlock = ^{
            if (weakSelf.clickAllBlock) {
                weakSelf.clickAllBlock(indexPath.section);
            }
        };
        if (indexPath.section == 0) {
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZAdvisorDetailHeaderView class]) forIndexPath:indexPath];
            return self.headerView;
        }else if (indexPath.section == 1){
            header.titleStr = @"服务项目";
            header.tagList.hidden = YES;
        }else if (indexPath.section == 2){
            header.titleStr = @"精华日记";
            [header setTags:self.diaryFilterArr];
        }else{
            header.titleStr = @"优秀评价";
            [header setTags:self.evaluateFilterArr];
        }
        return header;
    }else{
        CZAdvisorDetailCollectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CZAdvisorDetailCollectionFooterView class]) forIndexPath:indexPath];
        WEAKSELF
        footer.allBtnBlock = ^{
            if (weakSelf.clickAllBlock) {
                weakSelf.clickAllBlock(indexPath.section);
            }
        };
        if (indexPath.section == 0) {
            return nil;
        }else if (indexPath.section == 1){
            footer.titleStr = @"查看全部20个商品";
            footer.backgroundColor = CZColorCreater(245, 245, 249, 1);
            footer.lineView.hidden = YES;
        }else if (indexPath.section == 2){
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

- (CGFloat)getSectionHeaderHeight:(NSMutableArray *)arr{
    if (arr.count == 0) {
        return 0;
    }
    JCTagListView *tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-ScreenScale(60), 0)];
    tagList.tagCornerRadius = ScreenScale(28);
    tagList.tagBorderWidth = 1;
    tagList.tagBorderColor = CZColorCreater(244, 244, 248, 1);
    tagList.tagBackgroundColor = CZColorCreater(244, 244, 248, 1);
    tagList.tagSelectedBorderColor = CZColorCreater(51, 172, 253, 1);
    tagList.tagSelectedTextColor = CZColorCreater(51, 172, 253, 1);
    tagList.tagSelectedBackgroundColor = CZColorCreater(244, 244, 248, 1);
    tagList.tagTextColor = CZColorCreater(61, 67, 83, 1);
    tagList.tagFont = [UIFont systemFontOfSize:ScreenScale(24)];
    tagList.supportSelected = YES;
    tagList.tagContentInset = UIEdgeInsetsMake(ScreenScale(12), ScreenScale(20), ScreenScale(12), ScreenScale(20));
    tagList.tags = arr;
    return tagList.contentHeight;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
