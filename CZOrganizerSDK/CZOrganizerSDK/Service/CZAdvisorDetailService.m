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

@implementation CZAdvisorDetailService
/**
 *获取顾问详情
 *counselorId 顾问id
 */
-(void)requestForApiCounselorGetCounselorDetails:(NSString *)counselorId callBack:(CZAdvisorDetailBack)callBack{
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
            data = [QSCommonService removeNullFromArray:data];
        }
        
        if (callBack) {
            callBack(success , code , data , errorMessage);
        }
    }];
}

@end
