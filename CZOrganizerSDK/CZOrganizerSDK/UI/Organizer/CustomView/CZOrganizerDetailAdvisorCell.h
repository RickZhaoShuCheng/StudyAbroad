//
//  CZOrganizerDetailAdvisorCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/9.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAdvisorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailAdvisorCell : UICollectionViewCell
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) void (^selectAdvisorBlock)(CZAdvisorModel *model);
@end

NS_ASSUME_NONNULL_END
