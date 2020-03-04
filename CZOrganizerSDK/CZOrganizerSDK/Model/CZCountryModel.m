//
//  CZCountryModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCountryModel.h"

@implementation CZCountryModel

- (void)setValue:(id)value forKey:(NSString *)key{
    
    //手动处理description
    if ([key isEqualToString: @"id"]) {
        
        _ID = value;
    }else{
    
    //调用父类方法，保证其他属性正常加载
        [super setValue:value forKey:key];
    }
}

#pragma mark - NSCoping

- (id)copyWithZone:(NSZone __unused *)zone {
    CZCountryModel *model = [[CZCountryModel alloc] init];
    model.ID = self.ID;
    model.area_name = self.area_name;
    model.pid = self.pid;
    model.level = self.level;
    model.code = self.code;
    model.language_code = self.language_code;
    model.lat = self.lat;
    model.lng = self.lng;
    model.hot = self.hot;

    return model;
}

@end
