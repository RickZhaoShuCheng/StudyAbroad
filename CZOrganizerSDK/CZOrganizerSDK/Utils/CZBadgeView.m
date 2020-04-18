//
//  CZBadgeView.m
//  CMChat
//
//  Created by zsc on 2016/12/9.
//  Copyright © 2017年 zsc All rights reserved.
//

#import "CZBadgeView.h"

#define kVerticalMargin 4
#define kHorizontalMargin 10

@implementation CZBadgeView
{
    CGSize textSize;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self commonInit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self commonInit];
    return self;
}

-(void)commonInit
{
    self.color = CZColorCreater(255, 77, 79,1);
    self.textColor = [UIColor whiteColor];
    self.numberOfLines = 1;
    self.font = [UIFont systemFontOfSize:11];
    self.layer.masksToBounds = YES;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    //nothing
}

-(void)setText:(NSString *)text
{
    //nothing
}

-(void)setColor:(UIColor *)color
{
    [super setBackgroundColor:color];
}

-(UIColor *)color
{
    return [super backgroundColor];
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    [super setText:badgeValue];
    
    [self sizeToFit];
}

-(void)setStyle:(CZBadgeViewStyle)style
{
    if (_style != style) {
        _style = style;
        
        if (style != CZBadgeViewStyleDefault) {
            [super setText:nil];
        }
        
        [self sizeToFit];
    }
}

-(void)sizeToFit
{
    CGRect bounds = CGRectZero;
    if (self.style == CZBadgeViewStyleDefault) {
        [super sizeToFit];
        bounds.size = CGSizeMake(ceilf(self.bounds.size.width), ceilf(self.bounds.size.height));
        textSize = bounds.size;
        bounds.size.height += kVerticalMargin;
        bounds.size.width += kHorizontalMargin;
        bounds.size.width = MAX(bounds.size.width, bounds.size.height);
    } else {
        bounds.size = CGSizeMake(dotRadius * 2, dotRadius * 2);
        textSize = bounds.size;
    }
    
    self.bounds = bounds;
    self.layer.cornerRadius = CGRectGetMidY(bounds);
}

-(void)drawTextInRect:(CGRect)rect
{
    CGFloat vMargin = (CGRectGetHeight(rect) - textSize.height) / 2;
    CGFloat hMargin = (CGRectGetWidth(rect) - textSize.width) / 2;
    CGRect newRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(vMargin, hMargin, vMargin, hMargin));
    [super drawTextInRect:newRect];
}

@end
