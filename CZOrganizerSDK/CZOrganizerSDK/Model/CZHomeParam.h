//
//  CZHomeParam.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZHomeParam : NSObject
@property (nonatomic , strong) NSString *userId;//用户id
@property (nonatomic , strong) NSNumber *serviceSource;//商品归属 1.机构 2.达人
@property (nonatomic , strong) NSNumber *smartSort;//智能排序（1.销量最多 2.案例最多 3.评分最高 4.离我最近 5.最新上架 6.价格最高 7.价格最低）
@property (nonatomic , strong) NSString *countryId;
@property (nonatomic , strong) NSString *cityId;
@property (nonatomic , strong) NSString *majorId;
@property (nonatomic , strong) NSNumber *productCategory;
@property (nonatomic , strong) NSString *educationType;
@property (nonatomic , strong) NSString *superviseType;
@property (nonatomic , strong) NSString *minPrice;
@property (nonatomic , strong) NSString *maxPrice;
@property (nonatomic , strong) NSNumber *pageNum;
@property (nonatomic , strong) NSNumber *pageSize;

-(NSDictionary *)dictonary;

@end

NS_ASSUME_NONNULL_END
