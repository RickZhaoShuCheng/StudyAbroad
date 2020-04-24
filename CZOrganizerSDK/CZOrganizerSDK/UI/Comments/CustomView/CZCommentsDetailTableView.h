//
//  CZCommentsDetailTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/15.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCommentsDetailHeaderView.h"
#import "CZProductModel.h"
#import "CZCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZCommentsDetailTableView : UITableView
@property (nonatomic ,strong) CZCommentsDetailHeaderView *headerView;
@property (nonatomic ,strong) CZCommentModel *model;
@property (nonatomic ,strong) NSMutableArray *dataArr;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
//点击商品
@property (nonatomic ,copy) void (^selectProductBlock)(CZProductModel *model);
//评价点赞
@property (nonatomic ,copy) void (^commentsPraiseBlock)(NSInteger rowIndex,UIButton *likeBtn);
@end

NS_ASSUME_NONNULL_END
