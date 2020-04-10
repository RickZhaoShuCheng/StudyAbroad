//
//  CZAdvisorModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorModel : NSObject
@property (nonatomic , strong) NSString *counselorId;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSString *counselorName;
@property (nonatomic , strong) NSString *counselorImg;
@property (nonatomic , strong) NSString *organId;
@property (nonatomic , strong) NSNumber *valStar;
@property (nonatomic , strong) NSNumber *ratePraise;
@property (nonatomic , strong) NSNumber *rateComplaint;
@property (nonatomic , strong) NSNumber *rateRepay;
@property (nonatomic , strong) NSNumber *productId;
@property (nonatomic , strong) NSNumber *valService;
@property (nonatomic , strong) NSNumber *valMajor;
@property (nonatomic , strong) NSString *keywords;
@property (nonatomic , strong) NSNumber *status;
@property (nonatomic , strong) NSString *statusReason;
@property (nonatomic , strong) NSNumber *gender;
@property (nonatomic , strong) NSNumber *workingTime;
@property (nonatomic , strong) NSString *goodAtId;
@property (nonatomic , strong) NSString *introduce;
@property (nonatomic , strong) NSNumber *sort;
@property (nonatomic , strong) NSString *phoneCode;
@property (nonatomic , strong) NSString *phone;
@property (nonatomic , strong) NSNumber *eduStartTime;
@property (nonatomic , strong) NSNumber *eduEndTime;
@property (nonatomic , strong) NSString *educationBackground;
@property (nonatomic , strong) NSString *schoolName;
@property (nonatomic , strong) NSNumber *askCount;
@property (nonatomic , strong) NSNumber *visitCount;
@property (nonatomic , strong) NSString *organName;
@property (nonatomic , strong) NSString *userPhoneCode;
@property (nonatomic , strong) NSString *userPhone;
@property (nonatomic , strong) NSString *countryName;
@property (nonatomic , strong) NSString *provinceName;
@property (nonatomic , strong) NSString *cityName;
@property (nonatomic , strong) NSString *disName;
@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *lng;
@property (nonatomic , strong) NSString *serviceCount;
@property (nonatomic , strong) NSNumber *fanCount;
@property (nonatomic , strong) NSNumber *commentsCount;
@property (nonatomic , strong) NSNumber *caseCount;
@property (nonatomic , strong) NSNumber *reserveCount;
@property (nonatomic , strong) NSNumber *askRanking;
@property (nonatomic , strong) NSString *dynamicVo;
@property (nonatomic , strong) NSNumber *productCount;
@property (nonatomic , strong) NSNumber *diaryCount;
@property (nonatomic , strong) NSString *filterDiary;
@property (nonatomic , strong) NSString *filterComment;
@property (nonatomic , strong) NSArray *adeptList;
@property (nonatomic , strong) NSString *flagMoneyEnsure;
@property (nonatomic , strong) NSString *flagMoney;
@property (nonatomic , strong) NSMutableArray *productVoList;
@property (nonatomic , strong) NSArray *dynamicVoList;
@property (nonatomic , strong) NSString *valSatisfaction;
@property (nonatomic , strong) NSString *popularity;
@property (nonatomic , strong) NSString *sales;
@property (nonatomic , strong) NSString *reputation;
@property (nonatomic , strong) NSMutableArray *comments;
@property (nonatomic , assign) CGFloat cellHeight;
@property (nonatomic , strong) NSString *address;

@end

NS_ASSUME_NONNULL_END
