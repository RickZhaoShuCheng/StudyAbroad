//
//  CZServiceCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZHomeModel;

NS_ASSUME_NONNULL_BEGIN

@interface CZServiceCell : UICollectionViewCell
@property (nonatomic , strong) CZHomeModel *model;
@end

NS_ASSUME_NONNULL_END
