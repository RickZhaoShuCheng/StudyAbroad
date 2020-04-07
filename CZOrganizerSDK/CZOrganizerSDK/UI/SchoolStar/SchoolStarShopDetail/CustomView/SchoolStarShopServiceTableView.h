//
//  SchoolStarShopServiceTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZProductVoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopServiceTableView : UITableView
@property (nonatomic ,strong) NSMutableArray *dataArr;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
//点击服务项目
@property (nonatomic ,copy) void (^selectProductBlock)(CZProductVoListModel *model);
@end

NS_ASSUME_NONNULL_END
