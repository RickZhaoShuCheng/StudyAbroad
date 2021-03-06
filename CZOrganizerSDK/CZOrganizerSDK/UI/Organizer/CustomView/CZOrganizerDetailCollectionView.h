//
//  CZOrganizerDetailCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerDetailHeaderView.h"
#import "CZOrganizerDetailCollectionHeadView.h"
#import "CZOrganizerDetailCollectionFooterView.h"
#import "CZOrganizerModel.h"
#import "CZAdvisorModel.h"
#import "CZCommentModel.h"
#import "CZProductVoListModel.h"
#import "CZDiaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailCollectionView : UICollectionView
@property (nonatomic ,strong)CZOrganizerDetailHeaderView *headerView;
@property (nonatomic ,assign)CGFloat tagListHeight;
@property (nonatomic ,strong)NSMutableArray *diaryFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateFilterArr;
@property (nonatomic ,strong) CZOrganizerModel *model;
@property (nonatomic ,strong) CZAdvisorModel *advisorModel;
@property (nonatomic ,copy) void (^clickAllBlock)(NSInteger index);
@property (nonatomic ,copy) dispatch_block_t clickDynamicBlock;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
/**
 * 选择日记筛选index
 */
@property (nonatomic,copy) void (^selectDiaryIndex)(NSInteger index);
/**
 * 选择评价筛选index
 */
@property (nonatomic,copy) void (^selectCommentIndex)(NSInteger index);
//点击评价
@property (nonatomic ,copy) void (^selectCommentBlock)(CZCommentModel *model);
//点击服务项目
@property (nonatomic ,copy) void (^selectProductBlock)(CZProductVoListModel *model);
//点击顾问
@property (nonatomic ,copy) void (^selectAdvisorBlock)(CZAdvisorModel *model);
//点击日记
@property (nonatomic ,copy) void (^selectDiaryBlock)(CZDiaryModel *model);
//点击折叠
@property (nonatomic ,copy) dispatch_block_t clickFoldBtnBlock;
//评价点赞
@property (nonatomic ,copy) void (^commentsPraiseBlock)(CZCommentModel *model , UIButton *likeBtn);
//设置日记筛选项
- (void)setDiaryFilter:(NSString *)filterStr;
//设置评价筛选项
- (void)setCommentFilter:(NSString *)filterStr;
@end

NS_ASSUME_NONNULL_END
