//
//  CZCitySelectView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZCitySelectView : UIView

- (instancetype)initWithAction:(MenuAction *)action;

- (void)showInView:(UIView *)containerView;
@end

NS_ASSUME_NONNULL_END
