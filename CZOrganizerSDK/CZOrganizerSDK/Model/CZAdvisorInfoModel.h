//
//  CZAdvisorInfoModel.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorInfoModel : NSObject
@property (nonatomic ,strong) NSString *adept;
@property (nonatomic ,strong) NSMutableArray *adeptList;
@property (nonatomic ,strong) NSString *askCount;
@property (nonatomic ,strong) NSNumber *askRanking;
@property (nonatomic ,strong) NSNumber *caseCount;
@property (nonatomic ,strong) NSString *cityName;
@property (nonatomic ,strong) NSString *comments;
@property (nonatomic ,strong) NSNumber *commentsCount;
@property (nonatomic ,strong) NSString *counselorId;
@property (nonatomic ,strong) NSString *counselorImg;
@property (nonatomic ,strong) NSString *counselorName;
@property (nonatomic ,strong) NSString *countryName;
@property (nonatomic ,strong) NSString *diaryCount;
@property (nonatomic ,strong) NSString *disName;
@property (nonatomic ,strong) NSString *dynamicVo;
@property (nonatomic ,strong) NSMutableArray *dynamicVoList;
@property (nonatomic ,strong) NSString *eduEndTime;
@property (nonatomic ,strong) NSString *eduStartTime;
@property (nonatomic ,strong) NSString *educationBackground;
@property (nonatomic ,strong) NSNumber *fanCount;
@property (nonatomic ,strong) NSString *filterComment;
@property (nonatomic ,strong) NSString *filterDiary;
@property (nonatomic ,strong) NSString *flagMoney;
@property (nonatomic ,strong) NSString *flagMoneyEnsure;
@property (nonatomic ,strong) NSNumber *gender;
@property (nonatomic ,strong) NSString *goodAtId;
@property (nonatomic ,strong) NSString *introduce;
@property (nonatomic ,strong) NSString *keywords;
@property (nonatomic ,strong) NSString *lat;
@property (nonatomic ,strong) NSString *lng;
@property (nonatomic ,strong) NSString *organId;
@property (nonatomic ,strong) NSString *organName;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *phoneCode;
@property (nonatomic ,strong) NSString *popularity;
@property (nonatomic ,strong) NSNumber *productCount;
@property (nonatomic ,strong) NSString *productVoList;
@property (nonatomic ,strong) NSString *provinceName;
@property (nonatomic ,strong) NSNumber *rateComplaint;
@property (nonatomic ,strong) NSNumber *ratePraise;
@property (nonatomic ,strong) NSNumber *rateRepay;
@property (nonatomic ,strong) NSString *reputation;
@property (nonatomic ,strong) NSString *reserveCount;
@property (nonatomic ,strong) NSString *sales;
@property (nonatomic ,strong) NSString *schoolName;
@property (nonatomic ,strong) NSNumber *serviceCount;
@property (nonatomic ,strong) NSNumber *servicePersonCount;
@property (nonatomic ,strong) NSNumber *sort;
@property (nonatomic ,strong) NSNumber *status;
@property (nonatomic ,strong) NSString *statusReason;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) NSString *userPhone;
@property (nonatomic ,strong) NSString *userPhoneCode;
@property (nonatomic ,strong) NSString *userTagList;
@property (nonatomic ,strong) NSNumber *valMajor;
@property (nonatomic ,strong) NSString *valSatisfaction;
@property (nonatomic ,strong) NSNumber *valService;
@property (nonatomic ,strong) NSString *valStar;
@property (nonatomic ,strong) NSNumber *visitCount;
@property (nonatomic ,strong) NSNumber *workingTime;
@end

NS_ASSUME_NONNULL_END
