//
//  AdvisorDynamicVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDynamicVC : UIViewController
@property (nonatomic ,strong) CZUserInfoModel *model;
@property (nonatomic ,strong) NSString *userId;
@end

NS_ASSUME_NONNULL_END
