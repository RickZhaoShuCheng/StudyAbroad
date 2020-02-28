//
//  QSNetworkManager.m
//  QSLoginSDK
//
//  Created by zsc on 2019/8/19.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSNetworkManager.h"
#import "QSClient.h"

#define kCMHttpConnectorMaxConcurrentOperationCount 10
#define QSHttpCode_SUCCESS 0

@interface QSNetworkManager ()<NSURLSessionDelegate>
{
    dispatch_queue_t queue;
    void *queueTag;
}

@property (nonatomic, copy) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation QSNetworkManager

-(instancetype)initWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = configuration;
        
        if (!config) {
            config = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        
        self.configuration = config;
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = kCMHttpConnectorMaxConcurrentOperationCount;
        
        queueTag = &queueTag;
        queue = dispatch_queue_create([[super description] UTF8String], DISPATCH_QUEUE_SERIAL);
        
        dispatch_queue_set_specific(queue, queueTag, queueTag, NULL);
    }
    return self;
}


-(void)free
{
    if (self.session) {
        [self.session invalidateAndCancel];
        self.session = nil;
    }
    queueTag = NULL;
    queue = NULL;
}

#pragma mark - Queue

//async
-(void)scheduleBlock:(dispatch_block_t)block
{
    if (!block)
    {
        return;
    }
    
    if (dispatch_get_specific(queueTag))
    {
        block();
    }
    else
    {
        dispatch_async(queue, block);
    }
}

//sync
-(void)performBlock:(dispatch_block_t)block
{
    if (!block)
    {
        return;
    }
    
    if (dispatch_get_specific(queueTag))
    {
        block();
    }
    else
    {
        dispatch_sync(queue, block);
    }
}

- (NSURLSessionDataTask *)sendAsyncRequestWithURLRequest:(NSURLRequest *)urlRequest
                                       completionHandler:(void (^)(NSInteger statusCode, id data, NSError *error, NSHTTPURLResponse *response))handler
{
    void (^m_handler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
           [QSClient logInfo:@"%@ %@", response, error];
        }
        
        NSInteger statusCode = -1;
        
        NSHTTPURLResponse *resp = nil;
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            resp = (NSHTTPURLResponse *)response;
            statusCode = resp.statusCode;
        }
        
        if (error) {
            statusCode = error.code;
        }
        
        if (statusCode == 200) {
            statusCode = QSHttpCode_SUCCESS;
        }
        
        
        NSError *e = nil;
        
        NSDictionary *jsonData;
        
        if (data) {
            jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        }
        
        if (jsonData) {
            id code = [jsonData objectForKey:@"code"];
            if ([code isKindOfClass:[NSNumber class]]) {
                statusCode = [code integerValue];
            }
            else if ([code isKindOfClass:[NSString class]]) {
                NSString *solveCode = [code stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
                if ([solveCode length] == 0) {
                    statusCode = [code integerValue];
                }
                else
                {
                    statusCode = kCFNetServiceErrorTimeout;
                }
            }
        }
        
        if (handler) {
            handler(statusCode, jsonData, error, resp);
        }
        
        [QSClient logInfo:@"response ==> %@" , jsonData];
    };
    
    NSURLSessionDataTask *sessionTask = [self taskWithRequest:urlRequest completionHandler:m_handler];
    
    [sessionTask resume];
    
    
    [QSClient logInfo:@"%@ %@", urlRequest, urlRequest.allHTTPHeaderFields];
    
    return sessionTask;
}

-(NSURLSessionDataTask *)taskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler
{
    __block NSURLSessionDataTask *task = nil;
    
    [self performBlock:^{
        [self setup];
        task = [self.session dataTaskWithRequest:request completionHandler:completionHandler];
    }];
    
    return task;
}

#pragma mark - Private API

-(void)setup
{
    if (!self.session) {
        
        NSURLSessionConfiguration *config = self.configuration;
        if (!config) {
            config = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        
        self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:self.operationQueue];
    }
}

-(void)clear
{
    [QSClient logInfo:@"clear %@", [self.session description]];
    self.session = nil;
}

-(void)invalidate
{
    [self scheduleBlock:^{
        [self.session invalidateAndCancel];
        [self clear];
    }];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
    [QSClient logInfo:@"%@ %@", session, error];
    [self scheduleBlock:^{
        if (self.session == session) {
            [self clear];
        }
    }];
}



@end
