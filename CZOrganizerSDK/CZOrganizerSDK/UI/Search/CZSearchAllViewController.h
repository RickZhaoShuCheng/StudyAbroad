//
//  CZSearchAllViewController.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/4/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZSearchAllViewController : UIViewController<CZScrollContentControllerDeleagte>
@property (nonatomic , strong , readonly)NSMutableArray *viewControllers;
@end

NS_ASSUME_NONNULL_END
