//
//  CZRecognizeGesTableView.m
//  CZPageScrollController
//
//  Created by zsc on 2020/2/20.
//  Copyright © 2020年 zsc. All rights reserved.
//

#import "CZRecognizeGesTableView.h"

@implementation CZRecognizeGesTableView


/**
 同时识别多个手势

 @param gestureRecognizer 手势
 @param otherGestureRecognizer 其他手势
 @return yes
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
