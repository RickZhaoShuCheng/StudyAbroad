//
//  QSHudView.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/27.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSProgressHUD.h"

@interface QSHudView : QSProgressHUD

+ (instancetype)showToastOnView:(UIView *)view
                          title:(NSString *)title
             customizationBlock:(void (^)(QSHudView *hudView))customization;

//用于所有的网络请求的Toast显示
+ (QSHudView *)showToastInView:(UIView *)view;

@end
