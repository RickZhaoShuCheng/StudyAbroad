//
//  CZAdvisorDetailService.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailService.h"
#import "QSClient.h"
#import "QSClientConfigeration.h"
#import "QSNetworkManagerUtil.h"
#import "QSCommonService.h"

static const NSString *ApiCounselorGetCounselorDetails = @"apiCounselor/getCounselorDetails";
static const NSString *ApiProductGetCounselorRecommendProduct = @"apiProduct/getCounselorRecommendProduct";
static const NSString *ApiDiaryFindCaseListByFilter = @"apiDiary/findCaseListByFilter";
static const NSString *ApiObjectCommentsFindComments = @"apiObjectComments/findComments";
static const NSString *ApiProductGetOrganRecommendProduct = @"apiProduct/getOrganRecommendProduct";
static const NSString *ApiCounselorGetCounselorListByOrganId = @"apiCounselor/getCounselorListByOrganId";
static const NSString *ApiObjectCommentsFindObjectCommentsBySocId = @"apiObjectComments/findObjectCommentsBySocId";
static const NSString *ApiProductGetProductDetail = @"apiProduct/getProductDetail";
static const NSString *ApiProductActivitySelectProductActivityInfo = @"apiProductActivity/selectProductActivityInfo";
static const NSString *ApiProductActivitySelectProductActivityByFilter = @"apiProductActivity/selectProductActivityByFilter";
static const NSString *ApiProductActivitySelectRecommendProductActivityList = @"apiProductActivity/selectRecommendProductActivityList";
static const NSString *ApiSportUserSelectSportUserInfo = @"apiSportUser/selectSportUserInfo";
static const NSString *ApiProductGetProductList = @"apiProduct/getProductList";
static const NSString *ApiObjectCommentsPraiseObjectCommentsPraise = @"apiObjectCommentsPraise/objectCommentsPraise";
static const NSString *ApiObjectCommentsPraiseCancelObjectCommentsPraise = @"apiObjectCommentsPraise/cancelObjectCommentsPraise";


@implementation CZAdvisorDetailService
/**
 *获取顾问详情
 *counselorId 顾问id
 */
-(void)requestForApiCounselorGetCounselorDetails:(NSString *)counselorId callBack:(CZAdvisorDetailBack)callBack{
    if (!counselorId) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiCounselorGetCounselorDetails];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,@"counselorId":counselorId};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取顾问下的服务项目
 *counselorId 顾问id
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductGetCounselorRecommendProduct:(NSString *)counselorId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    if (!counselorId) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetCounselorRecommendProduct];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,
                                 @"counselorId":counselorId,
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取顾问下的日记
 *caseType 1.机构 2.顾问 3.达人 4.商品
 *id 查询的类型id
 *filterSum 过滤条件 1 全部 2 最新 3.尽心尽责 4 有视频 5 值得信赖
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiDiaryFindCaseListByFilter:(NSString *)caseType idStr:(NSString *)idStr filterSum:(NSInteger)filterSum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    if (!idStr) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiDiaryFindCaseListByFilter];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"caseType":caseType,
                                 @"userId":userId,
                                 @"id":idStr,
                                 @"filterSum":[NSString stringWithFormat:@"%ld",(long)filterSum],
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取机构下的服务项目
 *organId 机构id
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductGetOrganRecommendProduct:(NSString *)organId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    if (!organId) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetOrganRecommendProduct];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,
                                 @"organId":organId,
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}
/**
 *获取机构下的顾问
 *organId 机构id
 */
-(void)requestForApiCounselorGetCounselorListByOrganId:(NSString *)organId callBack:(CZAdvisorDetailBack)callBack{
    if (!organId) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiCounselorGetCounselorListByOrganId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"organId":organId,
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}
/**
 *获取评价
 *commentsType 1.机构 2.顾问 3.达人 4.商品
 *id 查询的类型id
 *filterSum 过滤条件 智能排序
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiObjectCommentsFindComments:(NSString *)commentsType idStr:(NSString *)idStr filterSum:(NSInteger)filterSum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    if (!idStr) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiObjectCommentsFindComments];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"commentsType":commentsType,
                                 @"userId":userId,
                                 @"id":idStr,
                                 @"filterSum":[NSString stringWithFormat:@"%ld",(long)filterSum],
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取评价详情
 *socId 评价id
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiObjectCommentsFindObjectCommentsBySocId:(NSString *)socId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    if (!socId) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiObjectCommentsFindObjectCommentsBySocId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,
                                 @"socId":socId,
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取商品信息
 *productId 商品id
 */
-(void)requestForApiProductGetProductDetail:(NSString *)productId callBack:(CZAdvisorDetailBack)callBack{
    if (!productId) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetProductDetail];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,
                                 @"productId":productId};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}
/**
 *筛选查询活动
 *filterDic 筛选条件
 *pageNum 页数
 *pageSize 每页条数
 */
-(void)requestForApiProductActivitySelectProductActivityByFilter:(NSDictionary *)filterDic pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductActivitySelectProductActivityByFilter];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:filterDic];
    [parameters setValue:userId forKey:@"userId"];
    [parameters setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"pageNum"];
    [parameters setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pageSize"];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}
/**
 *获取活动详情
 *productId 商品id
 */
-(void)requestForApiProductActivitySelectProductActivityInfo:(NSString *)productId callBack:(CZAdvisorDetailBack)callBack{
    if (!productId) {
        return;;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductActivitySelectProductActivityInfo];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"productId":productId};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取推荐活动
 *productCategory 活动详情中的productCategory
 *productActivityId 当前活动详情中的productActivityId
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductActivitySelectRecommendProductActivityList:(NSString *)productCategory productActivityId:(NSString *)productActivityId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductActivitySelectRecommendProductActivityList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,//@"productCategory":productCategory,
                                 @"productActivityId":productActivityId,
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}
/**
 *获取达人店铺详情
 *sportUserId 达人用户id
 */
-(void)requestForApiSportUserSelectSportUserInfo:(NSString *)sportUserId callBack:(CZAdvisorDetailBack)callBack{
    if (!sportUserId) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSportUserSelectSportUserInfo];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,//@"productCategory":productCategory,
                                 @"sportUserId":sportUserId
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *获取机构、顾问、达人的商品
 *productType 商品归属（1.机构 2.顾问 3.达人）
 *idStr 归属id（例：机构id）
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductGetProductList:(NSString *)productType idStr:(NSString *)idStr pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack{
    if (!idStr) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetProductList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,//@"productCategory":productCategory,
                                 @"productType":productType,
                                 @"id":idStr,
                                 @"pageNum":[NSString stringWithFormat:@"%ld",(long)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *点赞---评论点赞
 *socId 评价id
 */
-(void)requestForApiObjectCommentsPraiseObjectCommentsPraise:(NSString *)socId callBack:(CZAdvisorDetailBack)callBack{
    if (!socId) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiObjectCommentsPraiseObjectCommentsPraise];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,
                                 @"socId":socId,
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

/**
 *取消点赞---评论取消点赞
 *socId 评价id
 */
-(void)ApiObjectCommentsPraiseCancelObjectCommentsPraise:(NSString *)socId callBack:(CZAdvisorDetailBack)callBack{
    if (!socId) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiObjectCommentsPraiseCancelObjectCommentsPraise];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,
                                 @"socId":socId,
    };
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    [headers setObject:userId forKey:@"userId"];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:parameters pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
        BOOL success = NO;
        NSString *errorMessage;
        
        if (code == 200) {
            code = QSHttpCode_SUCCESS;
        }
        
        if (code == QSHttpCode_SUCCESS) {
            success = YES;
        }
        
        errorMessage = [jsonData objectForKey:@"msg"];
        
        if (!errorMessage) {
            errorMessage = [error description];
        }
        
        id data = [jsonData objectForKey:@"data"];
        
        if ([data isKindOfClass:[NSNull class]]) {
            data = nil;
        }
        
        if (data) {
            data = [QSCommonService removeNullFromDictionary:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

@end
