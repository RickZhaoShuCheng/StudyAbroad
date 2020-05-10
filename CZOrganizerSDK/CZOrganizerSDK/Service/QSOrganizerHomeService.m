//
//  QSOrganizerHomeService.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "QSOrganizerHomeService.h"
#import "QSClient.h"
#import "QSClientConfigeration.h"
#import "QSNetworkManagerUtil.h"
#import "QSCommonService.h"

static const NSString *ApiPlaceholderFindPlaceholderMapBySpType = @"apiPlaceholder/findPlaceholderMapBySpType";
static const NSString *ApiSportUserGetHomePageSportUser = @"apiSportUser/getHomePageSportUser";
static const NSString *ApiProductActivitySelectHotProductActivity = @"apiProductActivity/selectHotProductActivity";
static const NSString *ApiProductGetDefaultProductList = @"apiProduct/getDefaultProductList";
static const NSString *ApiDiaryFindAllCaseList = @"apiDiary/findAllCaseList";
static const NSString *ApiSportUserGetSportUserListByFilter = @"apiSportUser/getSportUserListByFilter";
static const NSString *ApiSportUserGetMoreSportUserList = @"apiSportUser/getMoreSportUserList";
static const NSString *ApiCounselorGetCounselorListByFilter = @"apiCounselor/getCounselorListByFilter";
static const NSString *ApiOrganGetOrganListByFilter = @"apiOrgan/getOrganListByFilter";
static const NSString *ApiProductGetProductListByFilter = @"apiProduct/getProductListByFilter";
static const NSString *ApiOrganGetOrganDetails = @"apiOrgan/getOrganDetails";

static const NSString *ApiSportUserGetSportUserTopList = @"apiSportUser/getSportUserTopList";
static const NSString *ApiOrganGetOrganTopList = @"apiOrgan/getOrganTopList";
static const NSString *ApiCounselorGetCounselorTopList = @"apiCounselor/getCounselorTopList";
static const NSString *ApiProductGetHotSale = @"apiProduct/getHotSale";
static const NSString *ApiProductGetPopularityList = @"apiProduct/getPopularityList";
static const NSString *ApiProductGetPublicPraiseList = @"apiProduct/getPublicPraiseList";

static const NSString *ApiOrganSearchOrganListByName = @"apiOrgan/searchOrganListByName";
static const NSString *ApiCounselorSearchCounselorListByName = @"apiCounselor/searchCounselorListByName";
static const NSString *ApiSportUserSearchSportUserListByName = @"apiSportUser/searchSportUserListByName";
static const NSString *ApiProductSearchProductListByName = @"apiProduct/searchProductListByName";
static const NSString *ApiTypeFindHotSearchType = @"apiType/findHotSearchType";
static const NSString *ApiSysAreaFindAreaList = @"apiSysArea/findAreaListByName";

@implementation QSOrganizerHomeService

-(void)requestForApiPlaceholderFindPlaceholderMapBySpType:(NSNumber*)spType callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiPlaceholderFindPlaceholderMapBySpType];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = @{@"spType":spType};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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

-(void)requestForApiSportUserGetHomePageSportUser:(NSString*)userId
                                         callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSportUserGetHomePageSportUser];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = @{@"userId":userId};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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

//活动---查询热门活动
-(void)requestForapiProductActivitySelectHotProductActivityByUserId:(NSString*)userId
                                                            pageNum:(NSNumber*)pageNum
                                                           pageSize:(NSNumber*)pageSize
                                                           callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductActivitySelectHotProductActivity];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = @{@"userId":userId,@"pageNum":pageNum,@"pageSize":pageSize};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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


-(void)requestForApiProductGetDefaultProductListByParam:(CZHomeParam *)param
                                                callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetDefaultProductList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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

-(void)requestForApiDiaryFindAllCaseListByParam:(CZHomeParam *)param
                                       callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiDiaryFindAllCaseList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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

-(void)requestForApiSportUserGetSportUserListByFilterByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSportUserGetSportUserListByFilter];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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
-(void)requestForApiSportUserGetMoreSportUserListByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSportUserGetMoreSportUserList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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

-(void)requestForApiCounselorGetCounselorListByFilterByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiCounselorGetCounselorListByFilter];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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

-(void)requestForApiOrganGetOrganListByFilterByParam:(CZHomeParam *)param
                                            callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiOrganGetOrganListByFilter];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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

-(void)requestForApiProductGetProductListByFilterByParam:(CZHomeParam *)param
                                                callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetProductListByFilter];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *currentUserId = [QSClient userId];
    [headers setObject:currentUserId forKey:@"userId"];
    
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
 *获取机构详情
 *organId 机构id
 */
-(void)requestForApiOrganGetOrganDetails:(NSString *)organId callBack:(QSOrganizerHomeBack)callBack{
    if (!organId) {
        return;
    }
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiOrganGetOrganDetails];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *userId = [QSClient userId];
    
    NSDictionary *parameters = @{@"userId":userId,@"organId":organId};
    
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



//达人榜单
-(void)requestForApiSportUserGetSportUserTopListByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSportUserGetSportUserTopList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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

//机构榜单
-(void)requestForApiOrganGetOrganTopListByParam:(CZHomeParam *)param
                                            callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiOrganGetOrganTopList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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

//顾问榜
-(void)requestForApiCounselorGetCounselorTopListByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiCounselorGetCounselorTopList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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


//人气榜
-(void)requestForApiProductGetPopularityListByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetPopularityList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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


//热销榜
-(void)requestForApiProductGetHotSaleByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetHotSale];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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

//口碑榜
-(void)requestForApiProductGetPublicPraiseListByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductGetPublicPraiseList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    NSString *userId = [QSClient userId];
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

//首页--搜索--热门搜索--通过名称模糊搜索机构列表
-(void)requestForApiOrganSearchOrganListByNameByParam:(CZHomeParam *)param
                                             callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiOrganSearchOrganListByName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
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

//首页--搜索--热门搜索--通过名称模糊搜索顾问列表
-(void)requestForApiCounselorSearchCounselorListByNameByParam:(CZHomeParam *)param
                                             callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiCounselorSearchCounselorListByName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
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

//首页--搜索--热门搜索--通过名称模糊搜索达人列表
-(void)requestForApiSportUserSearchSportUserListByNameByParam:(CZHomeParam *)param
                                             callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSportUserSearchSportUserListByName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
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

//首页--搜索--热门搜索--通过名称模糊搜索商品列表
-(void)requestForApiProductSearchProductListByNameByParam:(CZHomeParam *)param
                                             callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiProductSearchProductListByName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
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

//首页---搜索---热门搜索
-(void)requestForApiTypeFindHotSearchTypeByCallBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiTypeFindHotSearchType];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
    [QSNetworkManagerUtil sendAsyncJSONRequestWithURL:url type:QSRequestPOST headers:headers parameters:nil pathParameters:nil completionHandler:^(NSInteger code, id  _Nonnull jsonData, NSError * _Nonnull error) {
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

-(void)requestForApiProductCommonListByParam:(CZHomeParam *)param
                                         url:(NSString *)urls
                                    callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, urls];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = [param dictonary];
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
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

//首页地区---通过地区名称模糊查询
-(void)requestForApiSysAreaFindAreaListByNameBySearchName:(NSString *)name
                                                 callBack:(QSOrganizerHomeBack)callBack
{
    NSString *baseURL = [QSClient sharedInstance].configeration.baseURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, ApiSysAreaFindAreaList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *parameters = @{@"areaName":name};
    
    NSMutableDictionary *headers = [[QSClient sharedInstance].configeration.headers mutableCopy];
    
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

@end
