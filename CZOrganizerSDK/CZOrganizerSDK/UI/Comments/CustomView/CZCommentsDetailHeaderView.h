//
//  CZCommentsDetailHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/15.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZCommentsDetailHeaderView : UIView
@property (nonatomic ,strong) SDCycleScrollView *cycleScrollView;
- (void)setImgArr:(NSMutableArray *)imgArr;
@end

NS_ASSUME_NONNULL_END
