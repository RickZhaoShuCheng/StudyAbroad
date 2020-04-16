//
//  SchoolStarShopDetailCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarShopServiceVC.h"
#import "CZSchoolStarShopCommentVC.h"
#import "CZSchoolStarShopCaseVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarShopDetailCell : UITableViewCell
@property (nonatomic ,strong) UIViewController *superVC;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSString *sportUserId;
@property (nonatomic ,strong) CZSchoolStarModel *model;
@property (nonatomic ,strong) CZSchoolStarShopServiceVC *serviceVC;
@property (nonatomic ,strong) CZSchoolStarShopCommentVC *commentVC;
@property (nonatomic ,strong) CZSchoolStarShopCaseVC *caseVC;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
