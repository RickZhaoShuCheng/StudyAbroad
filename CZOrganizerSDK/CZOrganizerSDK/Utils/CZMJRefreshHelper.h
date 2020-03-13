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
+ (MJRefreshNormalHeader *)lb_headerWithAction:(dispatch_block_t)action;
+ (MJRefreshNormalHeader *)lb_headerWithTarget:(id)target Action:(SEL)action;

/**
 *  MJ normal footer
 */
+ (MJRefreshBackStateFooter *)lb_footerWithAction:(dispatch_block_t)action;
+ (MJRefreshBackStateFooter *)lb_footerWithTarget:(id)target Action:(SEL)action;

@end
