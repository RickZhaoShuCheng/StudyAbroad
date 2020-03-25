//
//  CZActivityListTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZActivityListTableView : UITableView
@property (nonatomic ,copy) void (^didSelectCell)(NSString *str);
@end

NS_ASSUME_NONNULL_END
