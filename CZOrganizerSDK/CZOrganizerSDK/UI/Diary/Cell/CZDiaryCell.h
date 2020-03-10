//
//  CZDiaryCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CZDiaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZDiaryCell : UICollectionViewCell

@property (nonatomic , strong) CZDiaryModel *model;

@end

NS_ASSUME_NONNULL_END
