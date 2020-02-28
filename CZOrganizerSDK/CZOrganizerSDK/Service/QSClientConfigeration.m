//
//  QSClientConfigeration.m
//  QSLoginSDK
//
//  Created by zsc on 2019/9/17.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSClientConfigeration.h"

static NSString *onlineURL = @"http://222.186.36.88:8888/";

@implementation QSClientConfigeration

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.enableLog = YES;
    }
    return self;
}

- (NSString *)baseURL
{
    return onlineURL;
}

- (NSDictionary *)headers
{
    return @{@"appId":@"cjxb",@"token":@"sea"};
}

@end
