//
//  CZUserInfoModel.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZUserInfoModel : NSObject
@property (nonatomic ,strong) NSString *addressName;
@property (nonatomic ,strong) NSString *organAddress;
@property (nonatomic ,strong) NSString *adept;
@property (nonatomic ,strong) NSNumber *beginCreateTime;
@property (nonatomic ,strong) NSNumber *beginLoginTime;
@property (nonatomic ,strong) NSString *birth;
@property (nonatomic ,strong) NSString *birth1;
@property (nonatomic ,strong) NSString *birth2;
@property (nonatomic ,strong) NSNumber *businessStatus;
@property (nonatomic ,strong) NSString *cardId;
@property (nonatomic ,strong) NSString *cardImg;
@property (nonatomic ,strong) NSString *cityId;
@property (nonatomic ,strong) NSString *cityName;
@property (nonatomic ,strong) NSString *countryId;
@property (nonatomic ,strong) NSString *countryName;
@property (nonatomic ,strong) NSString *countyName;
@property (nonatomic ,strong) NSNumber *createTime;
@property (nonatomic ,strong) NSString *createTimeStr;
@property (nonatomic ,strong) NSString *curriculumImg;
@property (nonatomic ,strong) NSString *districtId;
@property (nonatomic ,strong) NSMutableArray *dynamicVoList;
@property (nonatomic ,strong) NSString *educationBackground;
@property (nonatomic ,strong) NSString *email;
@property (nonatomic ,strong) NSNumber *endCreateTime;
@property (nonatomic ,strong) NSNumber *endLoginTime;
@property (nonatomic ,strong) NSNumber *fansCount;
@property (nonatomic ,strong) NSNumber *focusCount;
@property (nonatomic ,strong) NSNumber *freezeStatus;
@property (nonatomic ,strong) NSNumber *freezeTime;
@property (nonatomic ,strong) NSNumber *gender;
@property (nonatomic ,strong) NSString *genderStr;
@property (nonatomic ,strong) NSString *groupId;
@property (nonatomic ,strong) NSString *groupName;
@property (nonatomic ,strong) NSNumber *isAuthentication;
@property (nonatomic ,strong) NSNumber *isEachFocus;
@property (nonatomic ,strong) NSNumber *isFocus;
@property (nonatomic ,strong) NSNumber *isGraduation;
@property (nonatomic ,strong) NSNumber *isRecommend;
@property (nonatomic ,strong) NSString *keywords;
@property (nonatomic ,strong) NSString *labelImg;
@property (nonatomic ,strong) NSString *labelName;
@property (nonatomic ,strong) NSString *labelPass;
@property (nonatomic ,strong) NSString *labelRefuseReason;
@property (nonatomic ,strong) NSNumber *loginTime;
@property (nonatomic ,strong) NSString *loginTimeStr;
@property (nonatomic ,strong) NSString *major;
@property (nonatomic ,strong) NSString *organName;
@property (nonatomic ,strong) NSNumber *organType;
@property (nonatomic ,strong) NSString *personImg;
@property (nonatomic ,strong) NSNumber *praiseCount;
@property (nonatomic ,strong) NSString *provinceId;
@property (nonatomic ,strong) NSNumber *publishCount;
@property (nonatomic ,strong) NSString *realName;
@property (nonatomic ,strong) NSString *refuseReason;
@property (nonatomic ,strong) NSString *role;
@property (nonatomic ,strong) NSString *schoolId;
@property (nonatomic ,strong) NSString *schoolName;
@property (nonatomic ,strong) NSString *schoolYear;
@property (nonatomic ,strong) NSString *selfIntroduction;
@property (nonatomic ,strong) NSString *semesterId;
@property (nonatomic ,strong) NSString *sportIntroduction;
@property (nonatomic ,strong) NSMutableArray *sportUserEduVos;
@property (nonatomic ,strong) NSNumber *updateTime;
@property (nonatomic ,strong) NSString *updateTimeStr;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) NSString *userImg;
@property (nonatomic ,strong) NSString *userInfo;
@property (nonatomic ,strong) NSString *userJointData;
@property (nonatomic ,strong) NSString *userLoginName;
@property (nonatomic ,strong) NSString *userNickName;
@property (nonatomic ,strong) NSString *userPhone;
@property (nonatomic ,strong) NSString *userPhoneCode;
@property (nonatomic ,strong) NSString *userPwd;
@property (nonatomic ,strong) NSString *userQq;
@property (nonatomic ,strong) NSString *userStatus;
@property (nonatomic ,strong) NSString *userToken;
@property (nonatomic ,strong) NSNumber *userType;
@property (nonatomic ,strong) NSString *userWx;

@property (nonatomic ,assign) BOOL introduceOpen;
@property (nonatomic ,assign) BOOL experienceOpen;
@property (nonatomic ,assign) CGFloat introduceHeight;
@property (nonatomic ,assign) CGFloat singleHeight;
@property (nonatomic ,strong) NSMutableArray *list;
@end

@interface CZSportEduModel : NSObject
@property (nonatomic ,strong) NSNumber *certificationStatus;
@property (nonatomic ,strong) NSString *countryId;
@property (nonatomic ,strong) NSString *countryName;
@property (nonatomic ,strong) NSNumber *createTime;
@property (nonatomic ,strong) NSString *educationBackground;
@property (nonatomic ,strong) NSNumber *endEducationTime;
@property (nonatomic ,strong) NSString *proveImg;
@property (nonatomic ,strong) NSString *realName;
@property (nonatomic ,strong) NSString *schoolName;
@property (nonatomic ,strong) NSNumber *sort;
@property (nonatomic ,strong) NSString *sportUserEduId;
@property (nonatomic ,strong) NSNumber *startEducationTime;
@property (nonatomic ,strong) NSNumber *status;
@property (nonatomic ,strong) NSNumber *studyStatus;
@property (nonatomic ,strong) NSNumber *updateTime;
@property (nonatomic ,strong) NSNumber *userId;
@end

NS_ASSUME_NONNULL_END
