//
//  CZAllServiceDiaryViewController.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZHomeModel.h"
#import "CZScrollContentControllerDeleagte.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAllServiceDiaryViewController : UIViewController<CZScrollContentControllerDeleagte>
@property (nonatomic, strong) CZHomeModel *model;
@end

NS_ASSUME_NONNULL_END
