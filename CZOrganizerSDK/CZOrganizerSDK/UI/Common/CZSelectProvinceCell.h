//
//  CZSelectCityCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/2.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZSCountryModel;

NS_ASSUME_NONNULL_BEGIN

@interface CZSelectProvinceCell : UITableViewCell
@property(nonatomic, strong) CZSCountryModel *model;
@property (nonatomic , assign) BOOL didSelect;
@end


NS_ASSUME_NONNULL_END
