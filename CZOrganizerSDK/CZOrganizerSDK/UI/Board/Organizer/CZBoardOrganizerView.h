//
//  CZBoardOrganizerView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardOrganizerView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy)void (^selectedBlock)(NSString *organId);
@property (nonatomic, copy)void (^selectedProductBlock)(NSString *productId);
@end

NS_ASSUME_NONNULL_END
