//
//  CZAdvisorView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy)dispatch_block_t selectBlock;
@end

NS_ASSUME_NONNULL_END
