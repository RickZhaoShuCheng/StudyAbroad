//
//  SchoolStarDetailPostVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarDetailPostTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarDetailPostVC : UIViewController
@property (nonatomic ,strong) SchoolStarDetailPostTableView *tableView;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) UIViewController *superVC;
@end

NS_ASSUME_NONNULL_END
