//
//  CZBoardView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardView.h"

#import "CZHomeModel.h"
#import "UIImageView+WebCache.h"

static CGFloat padding = 15;

static CGFloat innerPadding = 10;

@interface CZBoardView ()

@property (nonatomic,strong)NSArray<CZHomeModel *> *boards;

@property (nonatomic,strong)NSMutableArray<UIImageView *> *covers;

@property (nonatomic,strong)UIView *containerView;

@end


@implementation CZBoardView

- (instancetype)initWithBoards:(NSArray<CZHomeModel *> *)courses
                      container:(UIView *)container
{
    self = [super init];
    if (self) {
        self.boards = courses;
        CGFloat defaultWidth = container.bounds.size.width-2*padding;
        self.frame = CGRectMake(padding, 0, defaultWidth, defaultWidth);
        [container addSubview:self];
        [self layoutBaseViews];
    }
    return self;
}

-(void)updateLayoutByBoards:(NSArray<CZHomeModel *> *)courses
{
    self.boards = courses;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
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
    for (NSInteger index = 0; index < self.boards.count; index++) {
        UIImageView *cover = [[UIImageView alloc] init];
        cover.tag = index;
        [self.covers addObject:cover];
        CZHomeModel *model = self.boards[index];
        [cover sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.spImg)] placeholderImage:nil];
    }
    
    
    NSInteger count = self.covers.count;
    
    //三张布局以内
    if (count >= 3) {
        for (NSInteger i = 0; i < 4; i++) {
            UIImageView *view = self.covers[i];
            CGFloat coverWidth = (self.frame.size.width - 2*innerPadding)/3.0;
            view.frame = CGRectMake((coverWidth+innerPadding)*i, 0, coverWidth, coverWidth);
            [self addSubview:view];
        }
    }
    
    count = count - 3;
    
    if (count <=0) {
        return;
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.covers.firstObject.frame)+innerPadding, self.bounds.size.width, self.bounds.size.width/2.0)];
    [self addSubview:bottomView];
    
    //一张封面布局
    if (count == 1) {
        UIImageView *view = self.covers[3];
        view.frame = bottomView.bounds;
        [bottomView addSubview:view];
    }
    
    //两张封面布局
    if (count == 2) {
        UIImageView *view1 = self.covers[3];
        UIImageView *view2 = self.covers[4];
        CGFloat width = (bottomView.bounds.size.width - padding)/2.0;
        CGFloat height = bottomView.bounds.size.width;
        view1.frame = CGRectMake(0, 0, width, height);
        view2.frame = CGRectMake(CGRectGetMaxX(view1.frame)+padding, 0, width, height);
        [bottomView addSubview:view1];
        [bottomView addSubview:view2];
    }
    
    //三张封面布局
    if (count == 3) {
        UIImageView *view1 = self.covers[3];
        UIImageView *view2 = self.covers[4];
        UIImageView *view3 = self.covers[5];
        CGFloat width = (bottomView.bounds.size.width - padding)/2.0;
        CGFloat height = (bottomView.bounds.size.height - padding)/2.0;
        view1.frame = CGRectMake(0, 0, width, height);
        view2.frame = CGRectMake(CGRectGetMaxX(view1.frame)+padding, 0, width, height);
        view3.frame = CGRectMake(0, CGRectGetMaxY(view1.frame)+padding,self.bounds.size.width , height);
        [bottomView addSubview:view1];
        [bottomView addSubview:view2];
        [bottomView addSubview:view3];
    }
    
    if (count == 4) {
        for (NSInteger index=0; index < count; index++) {
            UIImageView *view = self.covers[index+3];
            CGFloat width = (bottomView.bounds.size.width - padding)/2.0;
            CGFloat height = (bottomView.bounds.size.height - padding)/2.0;
            NSInteger xPd = index%2;
            NSInteger yPd = index/2;
            view.frame = CGRectMake(xPd*(15+width), yPd*(15+height), width, height);
            [bottomView addSubview:view];
        }
    }
}

@end
