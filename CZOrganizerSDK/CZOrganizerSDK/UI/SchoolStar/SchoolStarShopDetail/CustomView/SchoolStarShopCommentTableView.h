//
//  SchoolStarShopCommentTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarShopCommentHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopCommentTableView : UITableView
@property (nonatomic ,strong) SchoolStarShopCommentHeaderView *headerView;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
