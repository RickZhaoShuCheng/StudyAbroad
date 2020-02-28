//
//  CZServiceBannerView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZServiceBannerView.h"
#import "CZServiceView.h"

static CGFloat const defaultHeight = 150;

@interface CZServiceBannerView ()

@property (nonatomic , strong) CZServiceView *serviceView;

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
    [self addSubview:self.serviceView];
}

-(void)reloadByDatas:(NSMutableArray *)datas
{
    self.serviceView.datas = datas;
    [self.serviceView reloadData];
}

@end
