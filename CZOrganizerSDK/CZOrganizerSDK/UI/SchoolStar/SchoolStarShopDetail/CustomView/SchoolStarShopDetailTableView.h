//
//  SchoolStarShopDetailTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarShopDetailCell.h"
#import "SchoolStarShopDetailTableHeaderView.h"
#import "CZSchoolStarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopDetailTableView : UITableView
@property (nonatomic ,strong) CZSchoolStarModel *model;
@property (nonatomic ,strong) SchoolStarShopDetailTableHeaderView *headerView;
@property (nonatomic ,strong) SchoolStarShopDetailCell *cell;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
