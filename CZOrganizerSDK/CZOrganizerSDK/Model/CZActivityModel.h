//
//  CZActivityModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZActivityModel : NSObject
@property (nonatomic , strong) NSString *productActivityId;
@property (nonatomic , strong) NSString *productId;
@property (nonatomic , strong) NSString *organId;
@property (nonatomic , strong) NSString *sportUserId;
@property (nonatomic , strong) NSString *extRangeUser;
@property (nonatomic , strong) NSString *extOrganization;
@property (nonatomic , strong) NSString *extAddress;
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , strong) NSNumber *createTime;
@property (nonatomic , assign) NSInteger activityType;//0.线上直播 1.线下活动
@property (nonatomic , strong) NSString *logo;
@property (nonatomic , strong) NSString *banners;
@property (nonatomic , strong) NSNumber *serviceTime;
@property (nonatomic , strong) NSString *priceType;
@property (nonatomic , strong) NSString *organName;
@property (nonatomic , strong) NSString *sportUserName;
@property (nonatomic , strong) NSString *userNickName;
@property (nonatomic , strong) NSNumber *price;
@property (nonatomic , strong) NSNumber *oldPrice;
@property (nonatomic , strong) NSNumber *applyPrice;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *desc;
@property (nonatomic , strong) NSString *countryId;
@property (nonatomic , strong) NSString *provinceId;
@property (nonatomic , strong) NSString *cityId;
@property (nonatomic , strong) NSString *disId;
@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *lng;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSNumber *flagApply;
@property (nonatomic , strong) NSNumber *flagMoney;
@property (nonatomic , strong) NSNumber *flagMoneyEnsure;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *buyReason;
@property (nonatomic , strong) NSNumber *reserveOrderCount;
@property (nonatomic , strong) NSString *countryName;
@property (nonatomic , strong) NSString *provinceName;
@property (nonatomic , strong) NSString *cityName;
@property (nonatomic , strong) NSString *disName;
@property (nonatomic , strong) NSString *leaderBoard;
@property (nonatomic , strong) NSNumber *diaryCount;
@property (nonatomic , strong) NSNumber *commentsCount;
@property (nonatomic , strong) NSString *filterComments;
@property (nonatomic , strong) NSNumber *isCollect;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSMutableArray *activitySessionList;
@property (nonatomic , strong) NSMutableArray *counselorVoList;
@property (nonatomic , strong) NSString *introduce;
//@property (nonatomic , strong) NSString *description;

@end

@interface CZActivitySession : NSObject
@property (nonatomic ,strong) NSString *productActivityId;
@property (nonatomic ,strong) NSString *spasId;
@property (nonatomic ,strong) NSNumber *beginTime;
@property (nonatomic ,strong) NSNumber *endTime;
@property (nonatomic ,assign) NSInteger status;
@end

NS_ASSUME_NONNULL_END
