//
//  CZSCountryModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZCountryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZSCountryModel : NSObject<NSCopying>

@property (nonatomic , copy) CZCountryModel *country;

@property (nonatomic , strong) NSArray *relatedArray;

@property (nonatomic , copy) CZSCountryModel *upLevelCountry;

@end

NS_ASSUME_NONNULL_END
