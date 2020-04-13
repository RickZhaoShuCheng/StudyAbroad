//
//  ActivityDetailHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "CZActivityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZActivityDetailHeaderView : UIView
@property (nonatomic ,strong) SDCycleScrollView *cycleView;
@property (nonatomic ,strong) CZActivityModel *model;
@end

NS_ASSUME_NONNULL_END
