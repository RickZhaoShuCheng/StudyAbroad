//
//  CZOrganizerModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerModel.h"

@implementation CZOrganizerModel

- (void)setValue:(id)value forKey:(NSString *)key{
    
    //手动处理description
    if ([key isEqualToString: @"description"]) {
        
        _desc = value;
    }else{
    
    //调用父类方法，保证其他属性正常加载
        [super setValue:value forKey:key];
    }
}


@end
