//
//  CZBoardProductListCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardProductListCell : UICollectionViewCell

@property (nonatomic , strong) CZProductModel *model;

@end

NS_ASSUME_NONNULL_END
