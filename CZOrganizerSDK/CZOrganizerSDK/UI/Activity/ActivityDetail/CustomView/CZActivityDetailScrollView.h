//
//  ActivityDetailScrollView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "CZActivityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZActivityDetailScrollView : UIScrollView
@property (nonatomic ,strong) SDCycleScrollView *cycleView;
@property (nonatomic ,strong) CZActivityModel *model;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
