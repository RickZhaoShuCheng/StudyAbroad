//
//  QSCommonService.m
//  QSLoginSDK
//
//  Created by zsc on 2019/8/28.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"

@interface QSCommonService ()

@property (nonatomic , strong) NSMutableDictionary *servicesDict;

@end

@implementation QSCommonService

+(instancetype)sharedInstance
{
    static QSCommonService *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(id)service:(QSServiceType)type
{
    Class c = [[self sharedInstance] classForType:type];
    
    if (c == NULL) {
        return nil;
    }
    
    NSMutableDictionary *services = [[self sharedInstance] servicesDict];
    
    NSString *key = NSStringFromClass([c class]);
    
    id object = [services objectForKey:key];
    
    if (!object) {
        
        @synchronized (object) {
            object = [[c alloc] init];
            [services setObject:object forKey:key];
        }
    }
    
    return object;
}

-(Class)classForType:(QSServiceType)type
{
    switch (type) {
        case QSServiceTypeOrganizerHome:
            return [QSOrganizerHomeService class];
        default:
            return NULL;
    }
}

-(NSMutableDictionary *)servicesDict
{
    if (!_servicesDict) {
        _servicesDict = [[NSMutableDictionary alloc] init];
    }
    return _servicesDict;
}

+(void)clear
{
    NSMutableDictionary *services = [[self sharedInstance] servicesDict];
    @synchronized (services) {
        [services removeAllObjects];
    }
}

/**
 * 删除Dictionary中的NSNull
 */
+ (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic{
    
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return [@{} mutableCopy];
    }
    
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys) {
        NSValue *value = dic[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class]) {
            mdic[strKey] = [[self class] removeNullFromDictionary:(NSDictionary *)value];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class]) {
            mdic[strKey] = [[self class] removeNullFromArray:(NSArray *)value];
        }// NSNull类型的数据转为@“”保存进字典
        else if ([value isKindOfClass:NSNull.class]) {
            mdic[strKey] = @"";
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = dic[strKey];
        }
    }
    return mdic;
}
/**
 * 删除NSArray中的NSNull
 */
+ (NSMutableArray *)removeNullFromArray:(NSArray *)arr{
    
    if (!arr || ![arr isKindOfClass:[NSArray class]]) {
        return @[];
    }
    
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSValue *value = arr[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class]) {
            [marr addObject:[[self class] removeNullFromDictionary:(NSDictionary *)value]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class]) {
            [marr addObject:[[self class] removeNullFromArray:(NSArray *)value]];
        }// NSNull类型的数据转为@“”添加进数组
        else if ([value isKindOfClass:NSNull.class]) {
            [marr addObject:@""];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class]) {
            [marr addObject:value];
        }
    }
    return marr;
}

@end
