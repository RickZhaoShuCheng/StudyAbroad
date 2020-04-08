//
//  CZAdvisorViewController.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"
#import "CZHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorViewController : UIViewController<CZScrollContentControllerDeleagte>
@property (nonatomic, strong) CZHomeModel *model;
@property (nonatomic , strong)void(^filterViewShow)(void);
@property (nonatomic, strong) NSString *keywords;
@end

NS_ASSUME_NONNULL_END
