//
//  QSNetworkManager+QSNetworkManagerUtil.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/19.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSNetworkManager.h"

#define QSHttpCode_SUCCESS 0

#define QSHttpCode_ERROR -1

@interface QSNetworkManagerUtil : QSNetworkManager

/**
 *  @brief 获取JSON数据
 *  method *
 *  request default(x-www-form-urlencoded)
 *  response JSON
 *  header Content-Type: application/x-www-form-urlencoded
 */
+ (void)sendAsyncJSONRequestWithURL:(NSURL *)url
                               type:(QSRequestMethod)type
                            headers:(NSDictionary *)headers
                         parameters:(NSDictionary *)parameters
                     pathParameters:(NSDictionary *)pathParameters
                  completionHandler:(void (^)(NSInteger code, id jsonData, NSError *error))handler;

/**
 *  @brief 获取JSON数据
 *  method POST
 *  request JSON
 *  response JSON
 *  header Content-Type: application/json
 */
+ (void)sendAsyncJSONRequestWithURL:(NSURL *)url
                            headers:(NSDictionary *)headers
                         parameters:(NSDictionary *)parameters
                  completionHandler:(void (^)(NSInteger code, id jsonData, NSError *error))handler;


@end
