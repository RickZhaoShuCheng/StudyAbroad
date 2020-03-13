//
//  CZCourseView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCourseView.h"
#import "CZCourseModel.h"
#import "CZHomeModel.h"
#import "UIImageView+WebCache.h"

static CGFloat padding = 15;

@interface CZCourseView ()

@property (nonatomic,strong)NSArray<CZCourseModel *> *courses;

@property (nonatomic,strong)NSMutableArray<UIImageView *> *covers;

@property (nonatomic,strong)UIView *containerView;

@end


@implementation CZCourseView

- (instancetype)initWithCourses:(NSArray<CZCourseModel *> *)courses
                      container:(UIView *)container
{
    self = [super init];
    if (self) {
        self.courses = courses;
        CGFloat defaultWidth = container.bounds.size.width-2*padding;
        CGFloat defaultHeight = defaultWidth/2.0;
        self.frame = CGRectMake(padding, 0, defaultWidth, defaultHeight);
        [container addSubview:self];
        [self layoutBaseViews];
    }
    return self;
}

-(void)updateLayoutByCourses:(NSArray<CZCourseModel *> *)courses
{
    self.courses = courses;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.covers removeAllObjects];
    [self layoutBaseViews];
}

-(NSMutableArray<UIImageView *> *)covers
{
    if (!_covers) {
        _covers = [[NSMutableArray alloc] init];
    }
    return _covers;
}

-(void)layoutBaseViews
{
    for (NSInteger index = 0; index < self.courses.count; index++) {
        UIImageView *cover = [[UIImageView alloc] init];
        cover.userInteractionEnabled = YES;
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForClickCover:)]];
        cover.tag = index;
        [self.covers addObject:cover];
        CZCourseModel *model = self.courses[index];
        [cover sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.cover)] placeholderImage:nil];
    }
    
    
    NSInteger count = self.covers.count;
    
    //一张封面布局
    if (count == 1) {
        UIImageView *view = self.covers.firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    
    //两张封面布局
    if (count == 2) {
        UIImageView *view1 = self.covers.firstObject;
        UIImageView *view2 = self.covers.lastObject;
        CGFloat width = (self.bounds.size.width - padding)/2.0;
        CGFloat height = self.bounds.size.width;
        view1.frame = CGRectMake(0, 0, width, height);
        view2.frame = CGRectMake(CGRectGetMaxX(view1.frame)+padding, 0, width, height);
        [self addSubview:view1];
        [self addSubview:view2];
    }
    
    //三张封面布局
    if (count == 3) {
        UIImageView *view1 = self.covers[0];
        UIImageView *view2 = self.covers[1];
        UIImageView *view3 = self.covers[2];
        CGFloat width = (self.bounds.size.width - padding)/2.0;
        CGFloat height = (self.bounds.size.height - padding)/2.0;
        view1.frame = CGRectMake(0, 0, width, height);
        view2.frame = CGRectMake(CGRectGetMaxX(view1.frame)+padding, 0, width, height);
        view3.frame = CGRectMake(0, CGRectGetMaxY(view1.frame)+padding,self.bounds.size.width , height);
        [self addSubview:view1];
        [self addSubview:view2];
        [self addSubview:view3];
    }
    
    if (count == 4) {
        for (NSInteger index=0; index < count; index++) {
            UIImageView *view = self.covers[index];
            CGFloat width = (self.bounds.size.width - padding)/2.0;
            CGFloat height = (self.bounds.size.height - padding)/2.0;
            NSInteger xPd = index%2;
            NSInteger yPd = index/2;
            view.frame = CGRectMake(xPd*(15+width), yPd*(15+height), width, height);
            [self addSubview:view];
        }
    }
}

-(void)actionForClickCover:(UIGestureRecognizer *)gesture
{
    if (self.clickBlock) {
        self.clickBlock(self.courses[gesture.view.tag]);
    }
}

@end
