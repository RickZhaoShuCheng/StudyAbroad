//
//  CZSchoolStarModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarModel : NSObject
@property (nonatomic , strong) NSString *sportUserId;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSNumber *flagMoney;
@property (nonatomic , strong) NSNumber *valProfessional;
@property (nonatomic , strong) NSNumber *valService;
@property (nonatomic , strong) NSNumber *valPrice;
@property (nonatomic , strong) NSNumber *valResponse;
@property (nonatomic , strong) NSNumber *valStar;
@property (nonatomic , strong) NSNumber *ratePraise;
@property (nonatomic , strong) NSNumber *rateComplaint;
@property (nonatomic , strong) NSNumber *rateRepay;
@property (nonatomic , strong) NSString *keywords;
@property (nonatomic , strong) NSNumber *status;
@property (nonatomic , strong) NSString *statusReason;
@property (nonatomic , strong) NSString *sportIntroduction;
@property (nonatomic , strong) NSString *goodAtId;
@property (nonatomic , strong) NSString *contactPhone;
@property (nonatomic , strong) NSString *email;
@property (nonatomic , strong) NSString *authenticationImg;
@property (nonatomic , strong) NSNumber *createTime;
@property (nonatomic , strong) NSString *realName;
@property (nonatomic , strong) NSString *userImg;
@property (nonatomic , strong) NSString *schoolId;
@property (nonatomic , strong) NSString *countryId;
@property (nonatomic , strong) NSNumber *startStudyTime;
@property (nonatomic , strong) NSNumber *isGraduation;
@property (nonatomic , strong) NSNumber *askCount;
@property (nonatomic , strong) NSNumber *visitCount;
@property (nonatomic , strong) NSNumber *balance;
@property (nonatomic , strong) NSString *goodAtName;
@property (nonatomic , strong) NSString *schoolName;
@property (nonatomic , strong) NSString *countryName;
@property (nonatomic , strong) NSString *provinceName;
@property (nonatomic , strong) NSString *cityName;
@property (nonatomic , strong) NSString *disName;
@property (nonatomic , strong) NSNumber *isFocus;
@property (nonatomic , strong) NSString *userName;
@property (nonatomic , strong) NSNumber *commentsCount;
@property (nonatomic , strong) NSNumber *fanCount;
@property (nonatomic , strong) NSString *educationBackground;
@property (nonatomic , strong) NSNumber *attentionCount;
@property (nonatomic , strong) NSNumber *caseCount;
@property (nonatomic , strong) NSNumber *reserveCount;
@property (nonatomic , strong) NSNumber *serviceCount;
@property (nonatomic , strong) NSNumber *servicePersonCount;
@property (nonatomic , strong) NSNumber *askRanking;
@property (nonatomic , strong) NSString *sportUserEduVos;
@property (nonatomic , strong) NSString *userRelationTypes;
@property (nonatomic , strong) NSString *studyYears;
@property (nonatomic , strong) NSString *myDynamicVo;
@property (nonatomic , strong) NSArray *productVoList;
@property (nonatomic , strong) NSString *lowPrice;
@property (nonatomic , strong) NSString *popularity;
@property (nonatomic , strong) NSString *sales;
@property (nonatomic , strong) NSString *reputation;
@property (nonatomic , strong) NSString *valSatisfaction;
@property (nonatomic , strong) NSArray *comments;
@property (nonatomic , strong) NSNumber *isCollect;
@property (nonatomic , assign) CGFloat cellHeight;

@property (nonatomic ,assign) BOOL introduceOpen;
@property (nonatomic ,assign) BOOL experienceOpen;
@property (nonatomic ,assign) CGFloat introduceHeight;
@property (nonatomic ,assign) CGFloat singleHeight;

@end

NS_ASSUME_NONNULL_END
