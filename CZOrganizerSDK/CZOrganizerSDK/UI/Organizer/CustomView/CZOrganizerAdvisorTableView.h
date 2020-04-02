//
//  CZOrganizerAdvisorTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAdvisorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerAdvisorTableView : UITableView
@property (nonatomic ,strong) NSMutableArray *dataArr;
//点击顾问
@property (nonatomic ,copy) void (^selectAdvisorBlock)(CZAdvisorModel *model);
@end

NS_ASSUME_NONNULL_END
