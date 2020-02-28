//
//  CZHomeModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZHomeModel : NSObject
@property (nonatomic , strong) NSString *androidCls;
@property (nonatomic , strong) NSString *androidPackage;
@property (nonatomic , strong) NSString *categoryCount;
@property (nonatomic , strong) NSString *content1;
@property (nonatomic , strong) NSString *content2;
@property (nonatomic , strong) NSString *content3;
@property (nonatomic , strong) NSString *content4;
@property (nonatomic , strong) NSString *content5;
@property (nonatomic , strong) NSNumber *createTime;
@property (nonatomic , strong) NSString *iosCls;
@property (nonatomic , strong) NSString *jsonParams;
@property (nonatomic , strong) NSNumber *sort;
@property (nonatomic , strong) NSNumber *spId;
@property (nonatomic , strong) NSString *spImg;
@property (nonatomic , strong) NSNumber *spType;
@property (nonatomic , strong) NSNumber *status;
@property (nonatomic , strong) NSNumber *updateTime;
@property (nonatomic , strong) NSString *url;
@property (nonatomic , strong) NSNumber *zoneType;

@end

NS_ASSUME_NONNULL_END
