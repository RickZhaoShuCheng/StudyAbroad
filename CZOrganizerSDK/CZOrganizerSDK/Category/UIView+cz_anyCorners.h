//
//  UIView+cz_anyCorners.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (cz_anyCorners)

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
