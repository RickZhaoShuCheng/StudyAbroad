//
//  CZSelectCityViewController.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSCountryModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CZSelectCityViewControllerDelegate <NSObject>

-(void)selectCity:(CZSCountryModel *)model viewController:(UIViewController *)vc;

@end

@interface CZSelectCityViewController : UIViewController

@property (nonatomic , weak) id<CZSelectCityViewControllerDelegate> delegate;

@property (nonatomic , assign) BOOL fromFilter;

@end

NS_ASSUME_NONNULL_END
