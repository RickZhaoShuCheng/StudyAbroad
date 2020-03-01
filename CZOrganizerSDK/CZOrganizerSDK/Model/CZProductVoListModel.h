//
//  CZProductVoListModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZProductVoListModel : NSObject
@property (nonatomic , strong) NSString *productId;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSNumber *productType;
@property (nonatomic , strong) NSString *organId;
@property (nonatomic , strong) NSString *sportUserId;
@property (nonatomic , strong) NSString *logo;
@property (nonatomic , strong) NSString *banners;
@property (nonatomic , strong) NSNumber *serviceTime;
@property (nonatomic , strong) NSString *priceType;
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
@property (nonatomic , strong) NSNumber *flagMoney;
@property (nonatomic , strong) NSNumber *flagMoneyEnsure;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSString *productCategory;
@property (nonatomic , strong) NSNumber *validTime;
@property (nonatomic , strong) NSString *schoolId;
@property (nonatomic , strong) NSString *noPassReason;
@property (nonatomic , strong) NSNumber *createTime;
@property (nonatomic , strong) NSString *sportProductSize;
@property (nonatomic , strong) NSString *del;
@property (nonatomic , strong) NSNumber *returnOrderCount;
@property (nonatomic , strong) NSNumber *useOrderCount;
@property (nonatomic , strong) NSNumber *finishOrderCount;
@property (nonatomic , strong) NSNumber *totalOrderCount;
@property (nonatomic , strong) NSNumber *distance;
@property (nonatomic , strong) NSNumber *payCount;
@property (nonatomic , strong) NSString *organName;
@property (nonatomic , strong) NSString *organLogo;
@property (nonatomic , strong) NSString *sportRealName;
@property (nonatomic , strong) NSString *sportUserImg;
@property (nonatomic , strong) NSString *countryName;
@property (nonatomic , strong) NSString *provinceName;
@property (nonatomic , strong) NSString *cityName;
@property (nonatomic , strong) NSString *disName;
@property (nonatomic , strong) NSString *leaderBoard;
@property (nonatomic , strong) NSNumber *reserveOrderCount;
@property (nonatomic , strong) NSNumber *diaryCount;
@property (nonatomic , strong) NSNumber *commentsCount;
@property (nonatomic , strong) NSNumber *isCollect;
@property (nonatomic , strong) NSNumber *isAddShoppingCart;
@property (nonatomic , strong) NSArray *counselorVoList;
@property (nonatomic , strong) NSArray *sportUserAdeptList;
@property (nonatomic , strong) NSNumber *askCount;
@property (nonatomic , strong) NSNumber *clickCount;
@property (nonatomic , strong) NSString *comments;


@end

NS_ASSUME_NONNULL_END
