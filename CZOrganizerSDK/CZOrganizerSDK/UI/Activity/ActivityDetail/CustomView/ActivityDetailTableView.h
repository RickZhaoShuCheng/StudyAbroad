//
//  ActivityDetailTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActivityDetailTableView : UITableView
@property (nonatomic ,strong) ActivityDetailHeaderView *headerView;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
