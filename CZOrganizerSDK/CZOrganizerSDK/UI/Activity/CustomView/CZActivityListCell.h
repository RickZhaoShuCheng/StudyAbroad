//
//  CZActivityListCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZActivityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZActivityListCell : UITableViewCell
@property (nonatomic ,strong) CZActivityModel *model;
@end

NS_ASSUME_NONNULL_END
