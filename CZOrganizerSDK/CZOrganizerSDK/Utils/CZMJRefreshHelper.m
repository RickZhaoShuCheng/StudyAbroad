//
//  MJRefreshHelper.h
//  KaTaoTao
//
//  Created by 谢朋远 on 2018/2/7.
//  Copyright © 2018年 谢朋远. All rights reserved.
//

#import "CZMJRefreshHelper.h"
@implementation CZMJRefreshHelper

+ (MJRefreshGifHeader *)lb_headerWithAction:(dispatch_block_t)action {
    //mjrefresh header
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 0; i<=30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%d", i]];
        if (image) {
            [idleImages addObject:image];
        }
    }
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    [header setImages:idleImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:idleImages duration:1.5 forState:MJRefreshStateRefreshing];
    return header;
}


+ (MJRefreshGifHeader *)lb_headerWithTarget:(id)target Action:(SEL)action {
    //mjrefresh header
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 0; i<=30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%d", i]];
        if (image) {
            [idleImages addObject:image];
        }
    }
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    [header setImages:idleImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:idleImages duration:1.5 forState:MJRefreshStateRefreshing];
    return header;
}


+ (MJRefreshBackNormalFooter *)lb_footerWithAction:(dispatch_block_t)action {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:action];
    [footer setTitle:@"——— 已经到底了 ———" forState:MJRefreshStateNoMoreData];
//    footer.stateLabel.textColor = colorWithHexString(@"e5e5e5");
//    footer.stateLabel.font = Font26;
//    footer.refreshingTitleHidden = YES;
//    footer.triggerAutomaticallyRefreshPercent = 0;
    return footer;
}


+ (MJRefreshBackNormalFooter *)lb_footerWithTarget:(id)target Action:(SEL)action {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    [footer setTitle:@"——— 已经到底了 ———" forState:MJRefreshStateNoMoreData];
//    footer.stateLabel.textColor = colorWithHexString(@"e5e5e5");
//    footer.stateLabel.font = Font26;
//    footer.refreshingTitleHidden = YES;
//    footer.triggerAutomaticallyRefreshPercent = 0;
    
    return footer;
}

@end
