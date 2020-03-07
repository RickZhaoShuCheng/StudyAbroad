//
//  CZServiceBannerView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZHomeModel.h"

extern CGFloat const defaultHeight;
extern CGFloat const pageControlHeight;

NS_ASSUME_NONNULL_BEGIN

@interface CZServiceBannerView : UIView

@property (nonatomic , strong) void(^select)(CZHomeModel *model);

- (instancetype)initLayoutByHeight:(CGFloat)height;

-(void)reloadByDatas:(NSMutableArray *)datas;

@end

NS_ASSUME_NONNULL_END
