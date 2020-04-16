//
//  SchoolStarShopServiceVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarShopServiceTableView.h"
#import "CZSchoolStarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarShopServiceVC : UIViewController
@property (nonatomic ,strong) CZSchoolStarShopServiceTableView *tableView;
@property (nonatomic ,strong) NSString *sportUserId;
@property (nonatomic ,strong) UIViewController *superVC;
@property (nonatomic ,strong) CZSchoolStarModel *starModel;
@end

NS_ASSUME_NONNULL_END
