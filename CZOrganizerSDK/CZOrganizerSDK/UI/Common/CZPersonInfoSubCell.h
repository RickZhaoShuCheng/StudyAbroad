//
//  CZPersonInfoSubCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZProductVoListModel;
@class CZOrganizerModel;

typedef enum : NSUInteger {
    CZPersonInfoSubCellTypeSchool,
    CZPersonInfoSubCellTypeAsk,
    CZPersonInfoSubCellTypeOrganizer,
} CZPersonInfoSubCellType;

NS_ASSUME_NONNULL_BEGIN

@interface CZPersonInfoSubCell : UITableViewCell

@property (nonatomic , strong) CZProductVoListModel *model;

@property(nonatomic, assign) CZPersonInfoSubCellType cellType;

@property (nonatomic , strong) CZOrganizerModel *omodel;

@end

NS_ASSUME_NONNULL_END
