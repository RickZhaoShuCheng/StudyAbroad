//
//  CZCarefullyChooseViewController.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"
#import "CZHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZCarefullyChooseViewController : UIViewController<CZScrollContentControllerDeleagte>
@property (nonatomic, strong) CZHomeModel *model;

@end

NS_ASSUME_NONNULL_END
