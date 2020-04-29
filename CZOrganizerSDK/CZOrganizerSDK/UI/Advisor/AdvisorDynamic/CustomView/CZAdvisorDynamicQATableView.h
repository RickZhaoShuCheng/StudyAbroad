//
//  CZAdvisorDynamicQATableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/28.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDynamicQATableView : UITableView
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
