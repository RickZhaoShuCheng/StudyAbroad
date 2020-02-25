//
//  CZPageScrollContentView.h
//  CZPageScrollController
//  cell中加载的子视图
//  Created by zsc on 2020/2/20.
//  Copyright © 2020年 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"
@protocol SSPageScrollContentDelegate;

@interface CZPageScrollContentView : UIView


/**
 是否允许滚动 默认为YES
 */
@property(nonatomic, assign) BOOL canScroll;
//
@property(nonatomic, weak) id<SSPageScrollContentDelegate> delegate;
// 内部视图
@property(nonatomic, strong, readonly) NSArray<UIViewController<CZScrollContentControllerDeleagte> *> *contentControllers;
// collectionView
@property(nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 选中的视图的索引值  默认为0
 */
@property(nonatomic) NSInteger selectIndex;


/**
 实例化

 @param frame 大小
 @param controllers 一组内部控制器
 @param rootController 根控制器
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
           contentControllers:(NSArray<UIViewController<CZScrollContentControllerDeleagte> *> *)controllers
               rootController:(UIViewController *)rootController;


@end


@protocol SSPageScrollContentDelegate<NSObject>

@optional
// view 开始滑动的时候
- (void)scrollViewWillBeginDragging:(CZPageScrollContentView *)scrollView;
// view 停止滑动的时候
- (void)scrollViewDidEndDragging:(CZPageScrollContentView *)scrollView
                      scrollView:(UIScrollView *)sender;
// 滚动到某一页的时候
- (void)scrollView:(CZPageScrollContentView *)scrollView
           atIndex:(NSInteger)index;

// 内部子视图已经滑到顶部
- (void)scrollView:(CZPageScrollContentView *)scrollView subViewsScrollToTop:(BOOL)top;

@end








