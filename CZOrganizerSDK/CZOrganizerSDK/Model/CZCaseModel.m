//
//  CZCaseModel.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/10.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCaseModel.h"

@implementation CZCaseModel
- (void)setValue:(id)value forKey:(NSString *)key{
    
    //手动处理description
    if ([key isEqualToString: @"newCommentTime"]) {
        
        _commentTime = value;
    }else{
    
    //调用父类方法，保证其他属性正常加载
        [super setValue:value forKey:key];
    }
}
@end

