//
//  CZAllBoardViewController.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAllBoardViewController : UIViewController
@property (nonatomic, strong) NSArray<CZHomeModel *> *models;
@property (nonatomic, strong) CZHomeModel *model;
@end

NS_ASSUME_NONNULL_END
