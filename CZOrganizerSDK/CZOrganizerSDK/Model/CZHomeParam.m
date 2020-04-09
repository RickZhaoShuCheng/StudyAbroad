//
//  CZHomeParam.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZHomeParam.h"

@implementation CZHomeParam

-(NSDictionary *)dictonary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (self.userId) [dict setObject:self.userId forKey:@"userId"];
    if (self.serviceSource) [dict setObject:self.serviceSource forKey:@"serviceSource"];
    if (self.smartSort) [dict setObject:self.smartSort forKey:@"smartSort"];
    if (self.countryId) [dict setObject:self.countryId forKey:@"countryId"];
    if (self.cityId) [dict setObject:self.cityId forKey:@"cityId"];
    if (self.majorId) [dict setObject:self.majorId forKey:@"majorId"];
    if (self.productCategory) [dict setObject:self.productCategory forKey:@"productCategory"];
    if (self.educationType) [dict setObject:self.educationType forKey:@"educationType"];
    if (self.superviseType) [dict setObject:self.superviseType forKey:@"superviseType"];
    if (self.minPrice) [dict setObject:self.minPrice forKey:@"minPrice"];
    if (self.maxPrice) [dict setObject:self.maxPrice forKey:@"maxPrice"];
    if (self.pageNum) [dict setObject:self.pageNum forKey:@"pageNum"];
    if (self.pageSize) [dict setObject:self.pageSize forKey:@"pageSize"];
    if (self.name) [dict setObject:self.name forKey:@"name"];

    return dict;
}

@end
