//
//  CZSCountryModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZCountryModel.h"
#import "ItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZSCountryModel : ItemModel

@property (nonatomic , strong) CZCountryModel *country;

@property (nonatomic , strong) NSArray *relatedArray;

@end

NS_ASSUME_NONNULL_END
