//
//  CZAdvisorModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorModel.h"

@implementation CZAdvisorModel

+ (NSDictionary *)arrayContainModelClass
{
    return @{@"productVoList":@"CZProductVoListModel",@"comments":@"CZCommentModel"};
}

-(NSMutableArray *)productVoList
{
    if ([_productVoList isKindOfClass:[NSString class]]) {
        return @[];
    }
    
    return _productVoList;
}

-(NSMutableArray *)comments
{
    if ([_comments isKindOfClass:[NSString class]]) {
        return @[];
    }
    
    return _comments;
}

@end
