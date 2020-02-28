//
//  NSObject+ORM.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/30.
//  Copyright © 2019 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QSModelDelegate <NSObject>

@optional

+ (NSDictionary *)arrayContainModelClass;

+ (NSDictionary *)dictWithModelClass;

@end

@interface NSObject (ORM)

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
