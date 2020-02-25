//
//  CZHomeFilterView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropMenuBar;

NS_ASSUME_NONNULL_BEGIN

@interface CZHomeFilterView : UIView

- (instancetype)initWithSuperView:(UIView *)superView;

@property (nonatomic, strong , readonly) DropMenuBar *menuScreeningView;

@end

NS_ASSUME_NONNULL_END
