//
//  CZAdvisorDetailServiceCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZProductVoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailServiceCell : UICollectionViewCell
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong) CZProductVoListModel *model;
@end

NS_ASSUME_NONNULL_END
