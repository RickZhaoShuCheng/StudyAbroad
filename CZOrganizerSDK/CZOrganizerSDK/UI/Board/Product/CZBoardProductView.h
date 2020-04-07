//
//  CZBoardProductView.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardProductView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy)void (^selectedBlock)(NSString *productId);
@end

NS_ASSUME_NONNULL_END
