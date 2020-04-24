//
//  CZCommentsListTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCommentModel.h"
#import "CZCommentsHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZCommentsListTableView : UITableView
@property (nonatomic ,strong) CZCommentsHeaderView *headerView;
- (void)setTagListTags:(NSMutableArray *)tagsArr;
@property (nonatomic ,strong)NSMutableArray *commentsArr;
//点击评价
@property (nonatomic ,copy) void (^selectedBlock)(CZCommentModel *model);
/**
 * 选择评价筛选index
 */
@property (nonatomic,copy) void (^selectCommentIndex)(NSInteger index);
//评价点赞
@property (nonatomic ,copy) void (^commentsPraiseBlock)(NSInteger rowIndex , UIButton *likeBtn);
@end

NS_ASSUME_NONNULL_END
