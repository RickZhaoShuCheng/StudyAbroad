//
//  CZSCountryModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSCountryModel.h"

@implementation CZSCountryModel

#pragma mark - NSCoping

- (id)copyWithZone:(NSZone __unused *)zone {
    CZSCountryModel *model = [[CZSCountryModel alloc] init];
    model.country = self.country;
    model.relatedArray = self.relatedArray;
    model.upLevelCountry = self.upLevelCountry;
    return model;
}

@end
