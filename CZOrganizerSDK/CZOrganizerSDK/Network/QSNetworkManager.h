//
//  QSNetworkManager.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/19.
//  Copyright © 2019 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    QSRequestPOST,
    QSRequestGET,
} QSRequestMethod;

@interface QSNetworkManager : NSObject

@property (nonatomic, copy, readonly) NSURLSessionConfiguration *configuration;

-(instancetype)initWithConfiguration:(NSURLSessionConfiguration *)configuration;

- (NSURLSessionDataTask *)sendAsyncRequestWithURLRequest:(NSURLRequest *)urlRequest
                                       completionHandler:(void (^)(NSInteger statusCode, id data, NSError *error, NSHTTPURLResponse *response))handler;
-(void)invalidate;

@end
