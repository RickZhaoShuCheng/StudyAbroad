//
//  CZHotActivityCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZActivityModel;

NS_ASSUME_NONNULL_BEGIN

@interface CZHotActivityCell : UICollectionViewCell

@property (nonatomic , strong) CZActivityModel *model;

@end

NS_ASSUME_NONNULL_END
