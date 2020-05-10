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
    return @{@"productVoList":@"CZProductVoListModel",@"comments":@"CZCommentModel",@"sportUserTagList":@"CZSportUserTag"};
}

-(NSMutableArray *)productVoList
{
    if ([_productVoList isKindOfClass:[NSString class]]) {
        return [NSMutableArray array];
    }
    return _productVoList;
}
-(NSMutableArray *)sportUserTagList
{
    if ([_sportUserTagList isKindOfClass:[NSString class]]) {
        return [NSMutableArray array];
    }
    return _sportUserTagList;
}
@end

@implementation CZSportUserTag

@end
