//
//  CZBoardOrganizerTopCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/9.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerModel.h"
#import "CZBoardProductListView.h"

typedef enum : NSUInteger {
    CZBoardOrganizerTopTypeGold,
    CZBoardOrganizerTopTypeSilver,
    CZBoardOrganizerTopTypeCopper,
} CZBoardOrganizerTopType;

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardOrganizerTopCell : UITableViewCell
@property (nonatomic , strong) CZOrganizerModel *model;
@property (nonatomic , assign) CZBoardOrganizerTopType type;
@property (nonatomic , strong) CZBoardProductListView *productListView;

@end

NS_ASSUME_NONNULL_END
