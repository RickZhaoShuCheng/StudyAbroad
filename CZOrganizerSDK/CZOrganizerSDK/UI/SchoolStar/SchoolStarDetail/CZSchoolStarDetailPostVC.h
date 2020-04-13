//
//  SchoolStarDetailPostVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarDetailPostTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarDetailPostVC : UIViewController
@property (nonatomic ,strong) CZSchoolStarDetailPostTableView *tableView;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) UIViewController *superVC;
@end

NS_ASSUME_NONNULL_END
