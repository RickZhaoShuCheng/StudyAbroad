//
//  MJRefreshHelper.h
//  KaTaoTao
//
//  Created by 谢朋远 on 2018/2/7.
//  Copyright © 2018年 谢朋远. All rights reserved.
//

#import "CZMJRefreshHelper.h"
@implementation CZMJRefreshHelper

+ (MJRefreshNormalHeader *)lb_headerWithAction:(dispatch_block_t)action {
    //mjrefresh header
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:action];
    return header;
}


+ (MJRefreshNormalHeader *)lb_headerWithTarget:(id)target Action:(SEL)action {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    return header;
}


+ (MJRefreshBackStateFooter *)lb_footerWithAction:(dispatch_block_t)action {
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:action];
    [footer setTitle:NSLocalizedString(@"——— 已经到底了 ———", nil) forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = [UIColor blackColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    footer.refreshingTitleHidden = YES;
//    footer.triggerAutomaticallyRefreshPercent = 0;
    return footer;
}


+ (MJRefreshBackStateFooter *)lb_footerWithTarget:(id)target Action:(SEL)action {
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:target refreshingAction:action];
    [footer setTitle:NSLocalizedString(@"——— 已经到底了 ———", nil) forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = [UIColor blackColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    footer.refreshingTitleHidden = YES;
//    footer.triggerAutomaticallyRefreshPercent = 0;
//
    return footer;
}

@end
