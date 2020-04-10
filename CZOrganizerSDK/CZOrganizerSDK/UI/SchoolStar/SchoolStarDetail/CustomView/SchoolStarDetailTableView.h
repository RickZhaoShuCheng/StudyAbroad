//
//  SchoolStarDetailTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZUserInfoModel.h"
#import "SchoolStarDetailTableHeaderView.h"
#import "SchoolStarDetailCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarDetailTableView : UITableView
@property (nonatomic ,strong) CZUserInfoModel *model;
@property (nonatomic ,strong) SchoolStarDetailTableHeaderView *headerView;
@property (nonatomic ,strong) SchoolStarDetailCell *cell;
@property (nonatomic ,strong) UIViewController *superVC;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
