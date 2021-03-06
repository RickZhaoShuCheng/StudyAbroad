//
//  QSProductModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZProductModel.h"

@implementation CZProductModel

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
    return @{@"comments":@"CZCommentModel",@"counselorVoList":@"CZAdvisorInfoModel"};
}


@end
