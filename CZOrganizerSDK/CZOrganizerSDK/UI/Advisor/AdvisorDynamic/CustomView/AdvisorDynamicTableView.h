//
//  AdvisorDynamicTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvisorDynamicTableHeaderView.h"
#import "CZAdvisorInfoModel.h"
#import "AdvisorDynamicCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface AdvisorDynamicTableView : UITableView
@property (nonatomic ,strong) CZAdvisorInfoModel *model;
@property (nonatomic ,strong) AdvisorDynamicTableHeaderView *headerView;
@property (nonatomic ,strong) AdvisorDynamicCell *cell;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
