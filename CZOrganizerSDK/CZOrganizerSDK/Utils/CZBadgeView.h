//
//  CZBadgeView.h
//  CMChat
//
//  Created by zsc on 2016/12/9.
//  Copyright © 2017年 zsc All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    CZBadgeViewStyleDefault = 0,
    CZBadgeViewStyleDot,
} CZBadgeViewStyle;

static const CGFloat dotRadius = 3.5f;

@interface CZBadgeView : UILabel

@property (nonatomic, assign) CZBadgeViewStyle style;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, copy) UIColor *color;

@end
