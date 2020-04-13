//
//  SchoolStarShopDetailTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarShopDetailCell.h"
#import "CZSchoolStarShopDetailTableHeaderView.h"
#import "CZSchoolStarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarShopDetailTableView : UITableView
@property (nonatomic ,strong) UIViewController *superVC;
@property (nonatomic ,strong) CZSchoolStarModel *model;
@property (nonatomic ,strong) CZSchoolStarShopDetailTableHeaderView *headerView;
@property (nonatomic ,strong) CZSchoolStarShopDetailCell *cell;
@property (nonatomic ,copy) dispatch_block_t clickAvatarBlock;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
