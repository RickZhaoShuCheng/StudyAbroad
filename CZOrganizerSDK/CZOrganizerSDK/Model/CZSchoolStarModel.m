//
//  CZSchoolStarModel.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarModel.h"

@implementation CZSchoolStarModel

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
@end
