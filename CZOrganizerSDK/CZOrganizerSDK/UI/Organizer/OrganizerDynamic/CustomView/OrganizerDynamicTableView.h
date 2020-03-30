//
//  OrganizerDynamicTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrganizerDynamicTableHeaderView.h"
#import "CZOrganizerModel.h"
#import "OrganizerDynamicCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrganizerDynamicTableView : UITableView
@property (nonatomic ,strong) CZOrganizerModel *model;
@property (nonatomic ,strong) OrganizerDynamicTableHeaderView *headerView;
@property (nonatomic ,strong) OrganizerDynamicCell *cell;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
