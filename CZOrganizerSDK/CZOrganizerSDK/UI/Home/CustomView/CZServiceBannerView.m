//
//  CZServiceBannerView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZServiceBannerView.h"
#import "CZServiceView.h"


@interface CZPageControl : UIPageControl

@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *inactiveImage;
 
@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGSize inactiveImageSize;

@end

@implementation CZPageControl
  
- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}
 
- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
 
    [self updateDots];
}
 
 
- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            dot.image = self.currentImage;
            dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height);
        }else{
            dot.image = self.inactiveImage;
            dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, self.inactiveImageSize.width, self.inactiveImageSize.height);
        }
    }
}
- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
           
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}

@end


CGFloat const defaultHeight = 150;
CGFloat const pageControlHeight = 30;

@interface CZServiceBannerView ()<CZServiceViewDelegate>

@property (nonatomic , strong) CZServiceView *serviceView;

@property (nonatomic , strong) CZPageControl *pageControl;

@end

@implementation CZServiceBannerView

- (instancetype)initLayoutByHeight:(CGFloat)height
{
    self = [super init];
    if (self) {
        height = height?:defaultHeight;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.frame = CGRectMake(0, 0, width, height);
        [self layoutBaseViews];
    }
    return self;
}

-(void)layoutBaseViews
{
    self.serviceView = [[CZServiceView alloc] initWithFrame:self.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.serviceView.czDelegate = self;
    [self addSubview:self.serviceView];
    
    self.pageControl = [[CZPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.serviceView.frame), self.bounds.size.width, 6)];
    [self addSubview:self.pageControl];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.inactiveImage = [CZImageProvider imageNamed:@"zhu_ye_fu_wu_wei_xuan_zhong"];
    self.pageControl.inactiveImageSize = CGSizeMake(5, 5);
    self.pageControl.currentImage = [CZImageProvider imageNamed:@"zhu_ye_fu_wu_xuan_zhong"];
    self.pageControl.currentImageSize = CGSizeMake(12, 5);

}

-(void)reloadByDatas:(NSMutableArray *)datas
{
    self.serviceView.datas = datas;
    if (datas.count%8 >0) {
        self.pageControl.numberOfPages = datas.count/8+1;
    }
    else
    {
        self.pageControl.numberOfPages = datas.count/8;
    }
    self.pageControl.currentPage = 0;
    [self.serviceView reloadData];
}

-(void)serviceViewDidScroll:(NSInteger)pageIndex
{
    self.pageControl.currentPage = pageIndex;
}

@end
