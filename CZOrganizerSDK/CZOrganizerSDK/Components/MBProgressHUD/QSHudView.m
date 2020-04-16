//
//  QSHudView.m
//  QSLoginSDK
//
//  Created by zsc on 2019/8/27.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSHudView.h"

//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAlpa(rgbValue,alp) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

@interface QSBorderView : UIView

@end

@implementation QSBorderView

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(74, 74);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

@end

@interface QSHudView ()


@end

@implementation QSHudView

+ (instancetype)showToastOnView:(UIView *)view
                          title:(NSString *)title
             customizationBlock:(void (^)(QSHudView *hudView))customization
{
    if (view == nil) view = [self lastWindow];
    UIView *containerView = view;
    QSHudView *hud = [self showHUDAddedTo:containerView animated:YES];
    hud.mode = QSProgressHUDModeText;
    hud.minSize = CGSizeMake(176, 60);
    hud.bezelView.layer.cornerRadius = 4;
    hud.margin = 10;
    hud.yOffset -= 60;
    hud.bezelView.opaque = 0.7;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.text = title;
    hud.detailsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    hud.removeFromSuperViewOnHide = YES; //default
    hud.bezelView.backgroundColor = [UIColor blackColor];
    
    if (customization)
    {
        customization(hud);
    }
    
    return hud;
}

//用于所有的网络请求的Toast显示
+ (QSHudView *)showToastInView:(UIView *)view
{
    if (view == nil) view = [self lastWindow];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"joinMeetingLoading"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    QSHudView *hud = [[QSHudView alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    [hud show:YES];
    
    hud.yOffset -= 60;
    hud.backgroundColor = [UIColor clearColor];
    
    QSBorderView *borderView = [[QSBorderView alloc] initWithFrame:CGRectMake(0, 0, 74, 74)];

    UIView *bgView = [[UIView alloc] init];
    [borderView addSubview:bgView];
    [bgView addSubview:imageView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(74);
        make.center.mas_equalTo(0);
    }];
    
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = NO;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.shadowColor = UIColorFromRGB(0x7ea9fd).CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0,0);
    bgView.layer.shadowOpacity = 0.2;
    bgView.layer.shadowRadius = 10;

    
    [borderView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(30);
        make.center.mas_equalTo(0);
    }];
    hud.clipsToBounds = false;
    [hud setUserInteractionEnabled:YES];
    hud.customView = borderView;
    hud.mode = QSProgressHUDModeCustomView;
    hud.color = [UIColor clearColor];
    
    hud.bezelView.style = QSProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    [self startRorationWithDuration:1.2 view:imageView];

    return hud;
}

+ (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds) && !window.hidden)
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (void)startRorationWithDuration:(NSTimeInterval)duration view:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    animation.duration = duration;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [view.layer addAnimation:animation forKey:@"rotationAnimation"];
        });
    });
}

@end
