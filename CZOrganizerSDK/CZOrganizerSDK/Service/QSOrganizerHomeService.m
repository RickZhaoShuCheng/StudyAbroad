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
static const NSString *ApiCounselorGetCounselorListByFilter = @"apiCounselor/getCounselorListByFilter";
static const NSString *ApiOrganGetOrganListByFilter = @"apiOrgan/getOrganListByFilter";

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


@end
