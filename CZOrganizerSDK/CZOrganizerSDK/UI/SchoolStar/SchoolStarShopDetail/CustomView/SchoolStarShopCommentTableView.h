//
//  SchoolStarShopCommentTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarShopCommentHeaderView.h"
#import "CZCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopCommentTableView : UITableView
@property (nonatomic ,strong) SchoolStarShopCommentHeaderView *headerView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
//点击评价
@property (nonatomic ,copy) void (^selectCommentBlock)(CZCommentModel *model);
@end

NS_ASSUME_NONNULL_END
