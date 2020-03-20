//
//  CZOrganizerModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerModel : NSObject
@property (nonatomic , strong) NSString *organId;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSString *defaultUserId;
@property (nonatomic , strong) NSString *logo;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *countryId;
@property (nonatomic , strong) NSString *provinceId;
@property (nonatomic , strong) NSString *cityId;
@property (nonatomic , strong) NSString *disId;
@property (nonatomic , strong) NSString *lng;
@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *phone;
@property (nonatomic , strong) NSString *tel;
@property (nonatomic , strong) NSNumber *workTime;
@property (nonatomic , strong) NSNumber *buildTime;
@property (nonatomic , strong) NSString *buildArea;
@property (nonatomic , strong) NSString *desc;
@property (nonatomic , strong) NSString *creditCode;
@property (nonatomic , strong) NSNumber *flagBusiness;
@property (nonatomic , strong) NSNumber *flagPhoto;
@property (nonatomic , strong) NSNumber *flagMoney;
@property (nonatomic , strong) NSNumber *flagMoneyEnsure;
@property (nonatomic , strong) NSString *businessImgs;
@property (nonatomic , strong) NSString *honorImgs;
@property (nonatomic , strong) NSString *envImgs;
@property (nonatomic , strong) NSNumber *valProfessional;
@property (nonatomic , strong) NSNumber *valService;
@property (nonatomic , strong) NSNumber *valPrice;
@property (nonatomic , strong) NSNumber *valResponse;
@property (nonatomic , strong) NSNumber *valStar;
@property (nonatomic , strong) NSNumber *ratePraise;
@property (nonatomic , strong) NSNumber *rateComplaint;
@property (nonatomic , strong) NSNumber *rateRepay;
@property (nonatomic , strong) NSString *keywords;
@property (nonatomic , strong) NSString *regCapital;
@property (nonatomic , strong) NSString *regPersonName;
@property (nonatomic , strong) NSNumber *createTime;
@property (nonatomic , strong) NSNumber *updateTime;
@property (nonatomic , strong) NSNumber *status;
@property (nonatomic , strong) NSString *reason;
@property (nonatomic , strong) NSString *organTypeId;
@property (nonatomic , strong) NSString *businessName;
@property (nonatomic , strong) NSString *qualificationImg;
@property (nonatomic , strong) NSString *cardNo;
@property (nonatomic , strong) NSString *legalPersonPhone;
@property (nonatomic , strong) NSString *contactName;
@property (nonatomic , strong) NSString *contactPhone;
@property (nonatomic , strong) NSString *email;
@property (nonatomic , strong) NSString *positionName;
@property (nonatomic , strong) NSNumber *askCount;
@property (nonatomic , strong) NSNumber *visitCount;
@property (nonatomic , strong) NSNumber *balance;
@property (nonatomic , strong) NSString *organTypeName;
@property (nonatomic , strong) NSString *userPhoneCode;
@property (nonatomic , strong) NSString *countryName;
@property (nonatomic , strong) NSString *provinceName;
@property (nonatomic , strong) NSString *cityName;
@property (nonatomic , strong) NSString *disName;
@property (nonatomic , strong) NSNumber *isFocus;
@property (nonatomic , strong) NSString *userName;
@property (nonatomic , strong) NSString *counselorName;
@property (nonatomic , strong) NSNumber *commentsCount;
@property (nonatomic , strong) NSNumber *fanCount;
@property (nonatomic , strong) NSNumber *caseCount;
@property (nonatomic , strong) NSNumber *reserveCount;
@property (nonatomic , strong) NSNumber *serviceCount;
@property (nonatomic , strong) NSNumber *askRanking;
@property (nonatomic , strong) NSNumber *counselorCount;
@property (nonatomic , strong) NSString *myDynamicVo;
@property (nonatomic , strong) NSNumber *productCount;
@property (nonatomic , strong) NSNumber *diaryCount;
@property (nonatomic , strong) NSString *defaultCounselorVo;
@property (nonatomic , strong) NSString *distance;
@property (nonatomic , strong) NSString *valSatisfaction;
@property (nonatomic , strong) NSString *popularity;
@property (nonatomic , strong) NSString *sales;
@property (nonatomic , strong) NSString *reputation;
@property (nonatomic , strong) NSString *comments;
@property (nonatomic , strong) NSString *description;
@property (nonatomic , assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
