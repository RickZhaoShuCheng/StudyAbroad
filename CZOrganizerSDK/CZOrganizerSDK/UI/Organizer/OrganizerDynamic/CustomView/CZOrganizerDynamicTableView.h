//
//  OrganizerDynamicTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerDynamicTableHeaderView.h"
#import "CZOrganizerModel.h"
#import "CZOrganizerDynamicCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDynamicTableView : UITableView
@property (nonatomic ,strong) CZOrganizerModel *model;
@property (nonatomic ,strong) CZOrganizerDynamicTableHeaderView *headerView;
@property (nonatomic ,strong) CZOrganizerDynamicCell *cell;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
