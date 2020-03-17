//
//  CZAdvisorDetailCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAdvisorDetailHeaderView.h"
#import "CZAdvisorDetailCollectionHeadView.h"
#import "CZAdvisorDetailCollectionFooterView.h"
#import "CZAdvisorInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailCollectionView : UICollectionView
@property (nonatomic ,strong)CZAdvisorDetailHeaderView *headerView;
@property (nonatomic ,assign)CGFloat tagListHeight;
@property (nonatomic ,strong)NSMutableArray *diaryFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateArr;
@property (nonatomic ,strong) CZAdvisorInfoModel *model;
@property (nonatomic ,copy) void (^clickAllBlock)(NSInteger index);


/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
