//
//  CZBoardSchoolStarTopCell.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/20.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarModel.h"

typedef enum : NSUInteger {
    CZBoardSchoolStarTopTypeGold,
    CZBoardSchoolStarTopTypeSilver,
    CZBoardSchoolStarTopTypeCopper,
} CZBoardSchoolStarTopType;

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardSchoolStarTopCell : UITableViewCell
@property (nonatomic , strong) CZSchoolStarModel *model;
@property (nonatomic , assign) CZBoardSchoolStarTopType type;
@end

NS_ASSUME_NONNULL_END
