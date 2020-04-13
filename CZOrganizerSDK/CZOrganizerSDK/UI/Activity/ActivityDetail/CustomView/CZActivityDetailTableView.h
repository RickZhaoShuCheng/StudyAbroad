//
//  ActivityDetailTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZActivityDetailHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZActivityDetailTableView : UITableView
@property (nonatomic ,strong) CZActivityDetailHeaderView *headerView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) void (^didSelectCell)(NSString *str);
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
