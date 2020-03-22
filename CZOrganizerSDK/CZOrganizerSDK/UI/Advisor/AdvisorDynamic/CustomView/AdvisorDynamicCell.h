//
//  AdvisorDynamicCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvisorDynamicPostVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvisorDynamicCell : UITableViewCell
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) AdvisorDynamicPostVC *postVC;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
