//
//  CZServiceBannerView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZServiceBannerView : UIView

- (instancetype)initLayoutByHeight:(CGFloat)height;

-(void)reloadByDatas:(NSMutableArray *)datas;

@end

NS_ASSUME_NONNULL_END
