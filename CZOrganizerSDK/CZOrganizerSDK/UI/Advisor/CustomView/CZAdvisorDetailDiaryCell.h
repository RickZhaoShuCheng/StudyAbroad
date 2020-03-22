//
//  CZAdvisorDetailDiaryCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZDiaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailDiaryCell : UICollectionViewCell
@property (nonatomic ,strong)UIImageView *iconImg;
@property (nonatomic ,strong) CZDiaryModel *model;
@end

NS_ASSUME_NONNULL_END
