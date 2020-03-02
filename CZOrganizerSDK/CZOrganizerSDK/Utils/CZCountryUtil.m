//
//  CZCountryUtil.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCountryUtil.h"

static NSString *CountryPlistPath = @"/Plist/country.plist";

@interface CZCountryUtil ()
@property (nonatomic , strong) NSMutableArray *datas;
@end

@implementation CZCountryUtil

static CZCountryUtil *_instance = nil;
static dispatch_once_t onceToken;

+(instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

-(void)initData
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[self getCountryCompletePath]];
    NSMutableArray *countryDictArray = [dict[@"RECORDS"] mutableCopy];
    
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in countryDictArray) {
        CZCountryModel *model = [CZCountryModel modelWithDict:dict];
        CZSCountryModel *sModel = [[CZSCountryModel alloc] init];
        sModel.country = model;
        
        NSMutableArray *a = [d objectForKey:model.pid];
        if (!a)
        {
            a = [NSMutableArray array];
        }
        else
        {
            a = [NSMutableArray arrayWithArray:a];
        }
        
        [a addObject:sModel];
        [d setObject:a forKey:model.pid];
    }
    
    self.datas = [d objectForKey:@"1"];
    
    for (CZSCountryModel *model in self.datas) {
        NSArray *provinces = [d objectForKey:model.country.ID];
        model.relatedArray = provinces;
        
        for (CZSCountryModel *p in provinces) {
            NSArray *cities = [d objectForKey:p.country.ID];
            p.relatedArray = cities;
        }
    }
    NSLog(@"");
}

-(NSString *)getCountryCompletePath
{
    NSBundle *bundle = [NSBundle bundleForClass:[CZCountryUtil class]];
    NSString *bundlePath = [bundle pathForResource:@"CZOrganizerBundle" ofType:@"bundle"];
    NSString *filePath = [bundlePath stringByAppendingString:CountryPlistPath];
    return filePath;
}

@end
