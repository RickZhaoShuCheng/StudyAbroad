//
//  CZAdvisorInfoModel.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorInfoModel.h"

@implementation CZAdvisorInfoModel
+ (NSDictionary *)arrayContainModelClass
{
    return @{@"productVoList":@"CZProductVoListModel",@"comments":@"CZCommentModel",@"dynamicVoList":@"CZDynamicModel"};
}

@end
