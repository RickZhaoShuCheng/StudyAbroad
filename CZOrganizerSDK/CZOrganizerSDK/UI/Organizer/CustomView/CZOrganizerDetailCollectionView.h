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

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailCollectionView : UICollectionView
@property (nonatomic ,strong)CZOrganizerDetailHeaderView *headerView;
@property (nonatomic ,strong)CZOrganizerDetailCollectionHeadView *projectHeader;
@property (nonatomic ,strong)CZOrganizerDetailCollectionHeadView *advisorHeader;
@property (nonatomic ,strong)CZOrganizerDetailCollectionHeadView *diaryHeader;
@property (nonatomic ,strong)CZOrganizerDetailCollectionHeadView *evaluateHeader;
@property (nonatomic ,strong)CZOrganizerDetailCollectionFooterView *projectFooter;
@property (nonatomic ,strong)CZOrganizerDetailCollectionFooterView *diaryFooter;
@property (nonatomic ,strong)CZOrganizerDetailCollectionFooterView *evaluateFooter;
@property (nonatomic ,assign)CGFloat tagListHeight;
@property (nonatomic ,strong)NSMutableArray *diaryFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateFilterArr;
@property (nonatomic ,strong)NSMutableArray *evaluateArr;
@property (nonatomic ,strong) CZOrganizerModel *model;

/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
