//
//  CZBoardAdvisorTopCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAdvisorModel.h"

typedef enum : NSUInteger {
    CZBoardAdvisorTopTypeGold,
    CZBoardAdvisorTopTypeSilver,
    CZBoardAdvisorTopTypeCopper,
} CZBoardAdvisorTopType;

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardAdvisorTopCell : UITableViewCell
@property (nonatomic , strong) CZAdvisorModel *model;
@property (nonatomic , assign) CZBoardAdvisorTopType type;
@end

NS_ASSUME_NONNULL_END
