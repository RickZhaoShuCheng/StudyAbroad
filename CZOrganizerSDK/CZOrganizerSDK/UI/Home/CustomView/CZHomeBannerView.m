//
//  KTTHomeBannerView.m
//  KaTaoTao
//
//  Created by zsc on 2018/9/12.
//  Copyright © 2018年 ktt. All rights reserved.
//

#import "CZHomeBannerView.h"

#import "SDCycleScrollView.h"

#import "UIColor+PureColorImage.h"

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define BANNER_HEIGHT (ScreenWidth/2.0)

@interface CZHomeBannerView()

@property (nonatomic , strong) SDCycleScrollView *cycleScrollView;

@end


@implementation CZHomeBannerView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.userInteractionEnabled = YES;
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:
                            CGRectMake(0, 0, ScreenWidth, BANNER_HEIGHT) delegate:nil placeholderImage:nil];
    [self addSubview:self.cycleScrollView];
    self.cycleScrollView.autoScrollTimeInterval = 4.0;

//    self.cycleScrollView.pageControlDotSize = CGSizeMake(20.0, 6.0);
    
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    //设置图片视图显示类型·
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    //设置轮播视图的分页控件的显示
    self.cycleScrollView.showPageControl = YES;
    
    //设置轮播视图分也控件的位置
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    

    UIColor *selectColor = [UIColor whiteColor];
    UIColor *unselectColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];

    self.cycleScrollView.currentPageDotImage = [selectColor createImageByPureColorInSize:CGSizeMake(14, 4)];
    
    self.cycleScrollView.pageDotImage = [unselectColor createImageByPureColorInSize:CGSizeMake(14, 4)];
    
    self.frame = self.cycleScrollView.bounds;
}

-(void)setCustomView:(UIView *)customView
{
    _customView = customView;
    customView.userInteractionEnabled = YES;
    CGRect rect = self.frame;
    rect.size.height = BANNER_HEIGHT + CGRectGetHeight(customView.bounds);
    self.frame = rect;
    customView.frame = CGRectMake(0, CGRectGetHeight(self.cycleScrollView.frame), CGRectGetWidth(self.cycleScrollView.frame), CGRectGetHeight(customView.frame));
    [self addSubview:customView];
}

-(void)setPicsURLs:(NSArray *)picsURLs
{
    _picsURLs = picsURLs;
    self.cycleScrollView.imageURLStringsGroup = self.picsURLs;
}

-(void)setPicsImages:(NSArray *)picsImages
{
    _picsImages = picsImages;
    self.cycleScrollView.localizationImageNamesGroup = self.picsImages;
}
@end
