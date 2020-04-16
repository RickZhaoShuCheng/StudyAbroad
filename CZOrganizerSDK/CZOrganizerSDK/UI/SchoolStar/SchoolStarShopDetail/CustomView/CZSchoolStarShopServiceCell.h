//
//  SchoolStarShopServiceCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZProductVoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarShopServiceCell : UITableViewCell
@property (nonatomic ,strong) CZProductVoListModel *model;
@property (nonatomic ,copy) void (^clickCartBlock)(CZProductVoListModel *model);
@property (nonatomic ,copy) void (^clickBuyBlock)(CZProductVoListModel *model);
@end

NS_ASSUME_NONNULL_END
