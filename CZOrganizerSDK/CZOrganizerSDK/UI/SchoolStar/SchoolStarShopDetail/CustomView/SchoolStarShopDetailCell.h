//
//  SchoolStarShopDetailCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarShopServiceVC.h"
#import "SchoolStarShopCommentVC.h"
#import "SchoolStarShopCaseVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopDetailCell : UITableViewCell
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSString *sportUserId;
@property (nonatomic ,strong) SchoolStarShopServiceVC *serviceVC;
@property (nonatomic ,strong) SchoolStarShopCommentVC *commentVC;
@property (nonatomic ,strong) SchoolStarShopCaseVC *caseVC;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
