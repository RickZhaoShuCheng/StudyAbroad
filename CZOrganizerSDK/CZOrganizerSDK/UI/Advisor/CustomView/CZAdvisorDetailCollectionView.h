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
NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailCollectionView : UICollectionView
@property (nonatomic ,strong)CZAdvisorDetailHeaderView *headerView;
@property (nonatomic ,strong)CZAdvisorDetailCollectionHeadView *projectHeader;
@property (nonatomic ,strong)CZAdvisorDetailCollectionHeadView *diaryHeader;
@property (nonatomic ,strong)CZAdvisorDetailCollectionHeadView *evaluateHeader;
@property (nonatomic ,strong)CZAdvisorDetailCollectionFooterView *projectFooter;
@property (nonatomic ,strong)CZAdvisorDetailCollectionFooterView *diaryFooter;
@property (nonatomic ,strong)CZAdvisorDetailCollectionFooterView *evaluateFooter;
@property (nonatomic ,assign)CGFloat tagListHeight;
@property (nonatomic ,strong)NSMutableArray *diaryFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateArr;

/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END