//
//  CZOrganizerListView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerListView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy)void (^selectedBlock)(NSString *organId);
@end

NS_ASSUME_NONNULL_END
