//
//  CZRankView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZRankView : UIView

+(CZRankView *)instanceRankViewByRate:(CGFloat)rate;

-(void)setRankByRate:(CGFloat)rate;

@end

NS_ASSUME_NONNULL_END
