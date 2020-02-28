//
//  CZPageScrollViewController.h
//  CZPageScrollController
//  主页
//  Created by zsc on 2020/2/20.
//  Copyright © 2020年 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"
#import "CZPageScrollContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZPageScrollViewController : UIViewController

@property(nonatomic, strong, readonly) CZPageScrollContentView *scrollContentView;

@property(nonatomic, weak , readonly) UITableView *scrollMainTableView;

-(void)reloadData;

#pragma mark - Override(子类化实现下面的方法)
/**
 子类化的时候实现

 @return 一组子控制器
 */
- (NSArray<UIViewController<CZScrollContentControllerDeleagte> *> *)contentScrollers;

/**
 表单视图

 @return 表单头部视图
 */
- (UIView *)tableHeaderView;

/**
 配置tableView每组 Section的header图

 @param section section
 @return 视图
 */
- (UIView *)tableViewForHeaderInSection:(NSInteger)section;



- (UITableViewCell *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;


- (CGFloat)tableViewCellHeightForAtIndexPath:(NSIndexPath *)indexPath;


- (NSInteger)tableViewSectionCountForSection:(NSInteger)section;


- (NSInteger)setSectionCout;


- (void)didScrolling:(BOOL)canScroll;

-(void)scrollToBottom;

@end


NS_ASSUME_NONNULL_END



/*
 *
 *
 */













