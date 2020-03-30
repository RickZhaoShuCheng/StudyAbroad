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
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZOrganizerDetailEvaluateCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailEvaluateCell class])];
        [self registerClass:[CZOrganizerDetailServiceCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailServiceCell class])];
        [self registerClass:[CZOrganizerDetailDiaryCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class])];
        
        [self registerClass:[CZOrganizerDetailAdvisorCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailAdvisorCell class])];
        
        [self registerClass:[CZOrganizerDetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDetailHeaderView class])];
        [self registerClass:[CZOrganizerDetailCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"advisorHeader"];
        [self registerClass:[CZOrganizerDetailCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"serviceHeader"];
        [self registerClass:[CZOrganizerDetailCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diaryHeader"];
        [self registerClass:[CZOrganizerDetailCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"evaluateHeader"];
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
    if (model.myDynamicVo.count <= 0) {
        self.tagListHeight = self.tagListHeight - ScreenScale(96);
    }
    
    [self reloadData];
}

//设置日记筛选项
- (void)setDiaryFilter:(NSString *)filterStr{
    NSMutableArray *filterDiaryArr = [NSMutableArray array];
    if (filterStr.length) {
        [filterDiaryArr addObjectsFromArray:[filterStr componentsSeparatedByString:@","]];
    }
    [self.diaryFilterArr removeAllObjects];
    [self.diaryFilterArr addObjectsFromArray:filterDiaryArr];
}

//设置评价筛选项
- (void)setCommentFilter:(NSString *)filterStr{
    NSMutableArray *filterCommentArr = [NSMutableArray array];
    if (filterStr.length) {
        [filterCommentArr addObjectsFromArray:[filterStr componentsSeparatedByString:@","]];
    }
    [self.evaluateFilterArr removeAllObjects];
    [self.evaluateFilterArr addObjectsFromArray:filterCommentArr];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        if ([self.model.productVoList isKindOfClass:[NSString class]]) {
            return 0;
        }
        if (self.model.productVoList.count > 4) {
            return 4;
        }
        return self.model.productVoList.count;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        if ([self.model.diaryVoList isKindOfClass:[NSString class]]) {
            return 0;
        }
        if (self.model.diaryVoList.count > 4) {
            return 4;
        }
        return self.model.diaryVoList.count;
    }else{
        if ([self.model.commentList isKindOfClass:[NSString class]]) {
            return 0;
        }
        if (self.model.commentList.count >2) {
            return 2;
        }
        return self.model.commentList.count;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CZOrganizerDetailServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailServiceCell class]) forIndexPath:indexPath];
        CZProductVoListModel *model = self.model.productVoList[indexPath.row];
        cell.model = model;
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
        CZOrganizerDetailAdvisorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailAdvisorCell class]) forIndexPath:indexPath];
        cell.dataArr = self.model.advisorArray;
        return cell;
    }else if (indexPath.section == 3){
        CZOrganizerDetailDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailDiaryCell class]) forIndexPath:indexPath];
        CZDiaryModel *model = [CZDiaryModel modelWithDict:self.model.diaryVoList[indexPath.row]];
        cell.model = model;
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
    CZOrganizerDetailEvaluateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerDetailEvaluateCell class]) forIndexPath:indexPath];
    cell.model = [CZCommentModel modelWithDict:self.model.commentList[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth/2.0, ScreenScale(560));
    }else if (indexPath.section == 2){
        return CGSizeMake(kScreenWidth, ScreenScale(280));
    }else if (indexPath.section == 3){
        return CGSizeMake(kScreenWidth/2.0, ScreenScale(690));
    }
#warning 图片高度没算，最多支持6张图片，有机会再优化
    CZCommentModel *model = [CZCommentModel modelWithDict:self.model.commentList[indexPath.row]];
    CGFloat height = [self getStringHeightWithText:model.comment font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(142)];
    model.commentHeight = height;
    NSMutableArray *imgsArr = [NSMutableArray array];
    if (model.imgs.length) {
        [imgsArr addObjectsFromArray:[model.imgs componentsSeparatedByString:@","]];
    }
    if ([imgsArr count] == 0) {
        //无图片
        return CGSizeMake(kScreenWidth, ScreenScale(280) + model.commentHeight);
    }else if ([imgsArr count] <= 3) {
        //1-3张
        return CGSizeMake(kScreenWidth, ScreenScale(500) + model.commentHeight);
    }else{
        //4-6张
        return CGSizeMake(kScreenWidth, ScreenScale(700) + model.commentHeight);
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        if (self.selectCommentBlock) {
            self.selectCommentBlock([CZCommentModel modelWithDict:self.model.commentList[indexPath.row]]);
        }
    }
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size;
    if (section == 0) {
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(932)+self.tagListHeight);
    }else if (section == 3){
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(100)+ [self getSectionHeaderHeight:self.diaryFilterArr]) ;
    }else if (section == 4){
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(100) + [self getSectionHeaderHeight:self.evaluateFilterArr]);
    }else{
        return size = CGSizeMake([UIScreen mainScreen].bounds.size.width, ScreenScale(100));
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return CGSizeZero;
    }else if (section == 1){
        if ([self.model.productVoList isKindOfClass:[NSString class]] || self.model.productVoList.count == 0) {
            return CGSizeMake(0, 0);
        }
        return CGSizeMake(kScreenWidth, ScreenScale(130));
    }else{
        if ([self.model.commentList isKindOfClass:[NSString class]] || self.model.commentList.count == 0) {
            return CGSizeMake(0, 0);
        }
        return CGSizeMake(kScreenWidth, ScreenScale(130));
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        WEAKSELF
        if (indexPath.section == 0) {
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CZOrganizerDetailHeaderView class]) forIndexPath:indexPath];
            [self.headerView setClickDynamicBlock:^{
                if (weakSelf.clickDynamicBlock) {
                    weakSelf.clickDynamicBlock();
                }
            }];
            return self.headerView;
        }else if (indexPath.section == 1){
            CZOrganizerDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"serviceHeader" forIndexPath:indexPath];
            header.allBtnBlock = ^{
                if (weakSelf.clickAllBlock) {
                    weakSelf.clickAllBlock(indexPath.section);
                }
            };
            header.titleStr = @"为您推荐";
            header.contentStr = @"查看全部";
            header.tagList.hidden = YES;
            return header;
        }else if (indexPath.section == 2){
            CZOrganizerDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"advisorHeader" forIndexPath:indexPath];
            header.allBtnBlock = ^{
                if (weakSelf.clickAllBlock) {
                    weakSelf.clickAllBlock(indexPath.section);
                }
            };
            header.titleStr = @"顾问团队";
            header.contentStr = [NSString stringWithFormat:@"共%@个顾问",[@([self.model.counselorCount integerValue]) stringValue]];
            header.tagList.hidden = YES;
            return header;
        }else if (indexPath.section == 3){
            CZOrganizerDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diaryHeader" forIndexPath:indexPath];
            header.allBtnBlock = ^{
                if (weakSelf.clickAllBlock) {
                    weakSelf.clickAllBlock(indexPath.section);
                }
            };
            [header.tagList didSelectItem:^(NSInteger index) {
                if (weakSelf.selectDiaryIndex) {
                    weakSelf.selectDiaryIndex(index);
                }
            }];
            header.titleStr = @"精华日记";
            header.contentStr = @"全部";
            [header setTags:self.diaryFilterArr];
            return header;
        }else{
            CZOrganizerDetailCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"evaluateHeader" forIndexPath:indexPath];
            header.allBtnBlock = ^{
                if (weakSelf.clickAllBlock) {
                    weakSelf.clickAllBlock(indexPath.section);
                }
            };
            [header.tagList didSelectItem:^(NSInteger index) {
                if (weakSelf.selectCommentIndex) {
                    weakSelf.selectCommentIndex(index);
                }
            }];
            header.titleStr = @"优秀评价";
            header.contentStr = @"全部";
            [header setTags:self.evaluateFilterArr];
            return header;
        }
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
            footer.titleStr = [NSString stringWithFormat:@"查看全部%lu个商品",(unsigned long)self.model.productVoList.count];
            footer.backgroundColor = CZColorCreater(245, 245, 249, 1);
            footer.lineView.hidden = YES;
        }else if (indexPath.section == 3){
            footer.titleStr = @"查看全部日记";
            footer.backgroundColor = CZColorCreater(245, 245, 249, 1);
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
- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
@end
