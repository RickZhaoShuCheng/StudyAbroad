//
//  KTTMJRefreshHelper.h
//  KaTaoTao
//
//  Created by 谢朋远 on 2018/2/7.
//  Copyright © 2018年 谢朋远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZMJRefreshHelper.h"
#import "MJRefresh.h"

@interface CZMJRefreshHelper : NSObject

/**
 *  MJ gif header
 */
+ (MJRefreshGifHeader *)lb_headerWithAction:(dispatch_block_t)action;
+ (MJRefreshGifHeader *)lb_headerWithTarget:(id)target Action:(SEL)action;

/**
 *  MJ normal footer
 */
+ (MJRefreshBackNormalFooter *)lb_footerWithAction:(dispatch_block_t)action;
+ (MJRefreshBackNormalFooter *)lb_footerWithTarget:(id)target Action:(SEL)action;

@end
