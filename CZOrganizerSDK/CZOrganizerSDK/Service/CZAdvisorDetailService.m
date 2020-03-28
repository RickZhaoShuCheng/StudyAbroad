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
@end
