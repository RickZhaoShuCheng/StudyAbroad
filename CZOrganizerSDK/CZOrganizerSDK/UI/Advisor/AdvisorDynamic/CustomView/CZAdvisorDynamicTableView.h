//
//  AdvisorDynamicTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAdvisorDynamicTableHeaderView.h"
#import "CZUserInfoModel.h"
#import "CZAdvisorDynamicCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDynamicTableView : UITableView
@property (nonatomic ,strong) CZUserInfoModel *model;
@property (nonatomic ,strong) CZAdvisorDynamicTableHeaderView *headerView;
@property (nonatomic ,strong) CZAdvisorDynamicCell *cell;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
