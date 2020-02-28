//
//  QSNetworkManager+QSNetworkManagerUtil.m
//  QSLoginSDK
//
//  Created by zsc on 2019/8/19.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSNetworkManagerUtil.h"
#import "QSClient.h"

#define kCMHttpDefaultTimeoutInterval 60

static inline NSString * QSHttpManagerPercentEscapedStringFromString(NSString *string) {
    
    static NSString * const kCMCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kCMCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kCMCharactersGeneralDelimitersToEncode stringByAppendingString:kCMCharactersSubDelimitersToEncode]];
    
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
}

static inline NSString * QSHttpManagerQueryStringFromParameters(NSDictionary *parameters) {
    
    if (!parameters || parameters.count == 0) {
        return nil;
    }
    
    NSString *requestString;
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    for (NSString *keyString in  [parameters allKeys])
    {
        id value = [parameters objectForKey:keyString];
        
        NSString *valueString = nil;
        if (![value isKindOfClass:[NSString class]]) {
            valueString = [value description];
        } else {
            valueString = value;
        }
        
        requestString = [NSString stringWithFormat:@"%@=%@", QSHttpManagerPercentEscapedStringFromString(keyString), QSHttpManagerPercentEscapedStringFromString(valueString)];
        [requestArray addObject:requestString];
    }
    requestString = [requestArray componentsJoinedByString:@"&"];
    
    return requestString;
}

static inline NSString * QSHttpManagerURLPathStringFromParameters(NSDictionary *parameters) {
    
    if (!parameters || parameters.count == 0) {
        return nil;
    }
    
    NSString *requestString;
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    for (NSString *keyString in  [parameters allKeys])
    {
        id value = [parameters objectForKey:keyString];
        
        NSString *valueString = nil;
        if (![value isKindOfClass:[NSString class]]) {
            valueString = [value description];
        } else {
            valueString = value;
        }
        
        requestString = valueString;
        [requestArray addObject:QSHttpManagerPercentEscapedStringFromString(requestString)];
    }
    requestString = [requestArray componentsJoinedByString:@"/"];

    return requestString;
}


@implementation QSNetworkManagerUtil

+ (QSNetworkManagerUtil *)sharedInstance
{
    static QSNetworkManagerUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithConfiguration:nil];
    });
    
    return instance;
}

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
                  completionHandler:(void (^)(NSInteger code, id jsonData, NSError *error))handler
{
    NSError *err;
    
    NSURLRequest *request = [self requestFormDataWithURL:url type:(QSRequestMethod)type parameters:parameters pathParameters:pathParameters error:&err];
    if (!request) {
        if (handler) {
            handler(QSHttpCode_ERROR, nil, err);
        }
        return ;
    }
    
    NSMutableURLRequest *mutableRequest = nil;
    
    if ([request isKindOfClass:[NSMutableURLRequest class]]) {
        mutableRequest = (NSMutableURLRequest *)request;
    } else {
        mutableRequest = [request mutableCopy];
    }
    
    if (headers && headers.count > 0) {
        NSDictionary *headersDict = [headers copy];
        
        [headersDict enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }];
    }
    
    //CMLogVerbose(@"%@ %@", url, parameters);
    
    [QSClient logInfo:@"url = %@ parameters = %@ pathParameters = %@", url, parameters , pathParameters];

    
    [[self sharedInstance] sendAsyncRequestWithURLRequest:request completionHandler:^(NSInteger statusCode, id  _Nonnull data, NSError * _Nonnull error, NSHTTPURLResponse * _Nonnull response) {
        if (handler) {
            handler(statusCode , data , error);
        }
    }];
}

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
                  completionHandler:(void (^)(NSInteger code, id jsonData, NSError *error))handler
{
    NSError *err;
    
    NSURLRequest *request = [self requestApplicationJsonWithURL:url parameters:parameters error:&err];
    if (!request) {
        if (handler) {
            handler(QSHttpCode_ERROR, nil, err);
        }
        return ;
    }
    
    NSMutableURLRequest *mutableRequest = nil;
    
    if ([request isKindOfClass:[NSMutableURLRequest class]]) {
        mutableRequest = (NSMutableURLRequest *)request;
    } else {
        mutableRequest = [request mutableCopy];
    }
    
    if (headers && headers.count > 0) {
        NSDictionary *headersDict = [headers copy];
        
        [headersDict enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }];
    }
    
    //CMLogVerbose(@"%@ %@", url, parameters);
    
    [QSClient logInfo:@"url = %@ parameters = %@", url, parameters];
    
    [[self sharedInstance] sendAsyncRequestWithURLRequest:request completionHandler:^(NSInteger statusCode, id  _Nonnull data, NSError * _Nonnull error, NSHTTPURLResponse * _Nonnull response) {
        if (handler) {
            handler(statusCode , data , err);
        }
    }];
}


+ (NSURLRequest *)requestApplicationJsonWithURL:(NSURL *)url parameters:(NSDictionary *)parameters error:(NSError **)error
{
    NSData *data = nil;
    if (parameters) {
        NSError *err;
        data = [NSJSONSerialization dataWithJSONObject:parameters options:(NSJSONWritingOptions)0 error:&err];
        if (!data || err) {
            if (error) {
                *error = err;
            }
            return nil;
        }
    }
    
    //ignore type
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kCMHttpDefaultTimeoutInterval];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:data];
    
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];

    
    return request;
}

+ (NSURLRequest *)requestFormDataWithURL:(NSURL *)url type:(QSRequestMethod)type parameters:(NSDictionary *)parameters pathParameters:(NSDictionary *)pathParameters error:(NSError **)error
{
    NSString *requestString = nil;
    
    NSMutableURLRequest *request = nil;
    
    if (QSRequestGET == type) {
        
        NSURL *_url = url;
        
        if (pathParameters) {
            NSString *pathString = QSHttpManagerURLPathStringFromParameters(pathParameters);
            requestString = QSHttpManagerQueryStringFromParameters(parameters);
            _url = [NSURL URLWithString:[[_url absoluteString] stringByAppendingPathComponent:pathString]];
        }
        else
        {
            requestString = QSHttpManagerQueryStringFromParameters(parameters);
        }
        
        if (requestString) {
            _url = [NSURL URLWithString:[[_url absoluteString] stringByAppendingFormat:(_url.query ? @"&%@" : @"?%@"), requestString]];
        }
        
        request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kCMHttpDefaultTimeoutInterval];
        [request setHTTPMethod:@"GET"];
    } else if (QSRequestPOST == type) {
        
        requestString = QSHttpManagerQueryStringFromParameters(parameters);

        request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kCMHttpDefaultTimeoutInterval];
        [request setHTTPMethod:@"POST"];
        
        NSData *body = nil;
        
        if (requestString) {
            body = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        if (body) {
            [request setHTTPBody:body];
            
            [request setValue:[NSString stringWithFormat:@"%llu", (unsigned long long)[body length]] forHTTPHeaderField:@"Content-Length"];
        }
        
    } else {
        NSParameterAssert(NO);
    }
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString *host = url.host;
    [request addValue:host forHTTPHeaderField:@"Host"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];

    
    return request;
}



@end
