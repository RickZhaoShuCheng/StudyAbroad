//
//  CZRankView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZRankView.h"

static CGFloat const padding = 3;

@implementation CZRankView

+(CZRankView *)instanceRankViewByRate:(CGFloat)rate
{
    if (rate < 0 || rate > 5) {
        return nil;
    }
    
    CZRankView *rankView = [[CZRankView alloc] init];
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *rank = [[UIImageView alloc] init];
        rank.frame = CGRectMake(i*(padding+10), 0, 10, 10);
        rank.image = [CZImageProvider imageNamed:@"shou_ye_rank_0"];
        [rankView addSubview:rank];
        
        if (i < rate) {
            rank.image = [CZImageProvider imageNamed:@"shou_ye_rank_2"];
        }
        
        CGFloat tail = rate - floor(rate);
        if (tail > 0 && (floor(rate) == i)) {
            rank.image = [CZImageProvider imageNamed:@"shou_ye_rank_1"];
        }
    }
    return rankView;
}

@end
