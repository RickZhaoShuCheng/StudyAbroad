//
//  KTTHomeBannerView.h
//  KaTaoTao
//
//  Created by zsc on 2018/9/12.
//  Copyright © 2018年 ktt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCycleScrollView;

@interface CZHomeBannerView : UIView

@property (nonatomic , strong , readonly) SDCycleScrollView *cycleScrollView;

@property (nonatomic , strong) UIView *customView;

@property (nonatomic , copy) NSArray *picsURLs;

@property (nonatomic , copy) NSArray *picsImages;

@end
