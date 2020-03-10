//
//  CZCommonInstance.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommonInstance.h"

@implementation CZCommonInstance

static CZCommonInstance *_instance = nil;
static dispatch_once_t onceToken;

+(instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(NSMutableArray<CZHomeModel *> *)servies
{
    if (!_servies) {
        _servies = [[NSMutableArray alloc] init];
    }
    return _servies;
}

@end
