//
//  SchoolStarShopCommentTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarShopCommentHeaderView.h"
#import "CZCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarShopCommentTableView : UITableView
@property (nonatomic ,strong) CZSchoolStarShopCommentHeaderView *headerView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
//点击评价
@property (nonatomic ,copy) void (^selectCommentBlock)(CZCommentModel *model);
@end

NS_ASSUME_NONNULL_END
