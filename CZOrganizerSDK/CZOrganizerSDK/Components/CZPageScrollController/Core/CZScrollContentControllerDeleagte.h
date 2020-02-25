//
//  CZScrollContentControllerDeleagte.h
//  CZPageScrollController
//  中间内部子视图必须实现的方法
//  Created by zsc on 2020/2/20.
//  Copyright © 2020年 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CZScrollContentControllerDeleagte <NSObject>


/**
 子controller设定页面的偏移量 用于上层处理偏移变化
 */
//@property(nonatomic) CGPoint scrollContentOffset;
@property(nonatomic, strong) UIScrollView *contentScrollView;

@property(nonatomic) BOOL canScroll;

@end
