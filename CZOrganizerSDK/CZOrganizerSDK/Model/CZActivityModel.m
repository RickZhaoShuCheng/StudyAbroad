//
//  CZActivityModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityModel.h"

@implementation CZActivityModel

- (void)setValue:(id)value forKey:(NSString *)key{
    
    //手动处理description
    if ([key isEqualToString: @"description"]) {
        
        _desc = value;
    }else{
    
    //调用父类方法，保证其他属性正常加载
        [super setValue:value forKey:key];
    }
}

+ (NSDictionary *)arrayContainModelClass
{
    return @{@"activitySessionList":@"CZActivitySession",@"counselorVoList":@"CZAdvisorModel"};
}


@end

@implementation CZActivitySession


@end
