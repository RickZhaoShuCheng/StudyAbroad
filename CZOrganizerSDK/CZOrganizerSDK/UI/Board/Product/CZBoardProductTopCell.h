//
//  CZBoardProdcutTopCell.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZProductModel.h"

typedef enum : NSUInteger {
    CZBoardProductTopTypeGold,
    CZBoardProductTopTypeSilver,
    CZBoardProductTopTypeCopper,
} CZBoardProductTopType;

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardProductTopCell : UITableViewCell
@property (nonatomic , strong) CZProductModel *model;
@property (nonatomic , assign) CZBoardProductTopType type;
@end

NS_ASSUME_NONNULL_END
