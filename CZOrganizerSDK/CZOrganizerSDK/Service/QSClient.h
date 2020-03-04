//
//  QSClient.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/28.
//  Copyright © 2019 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QSClientConfigeration;


NS_ASSUME_NONNULL_BEGIN

@protocol QSClientDelegate <NSObject>

-(void)clientLoginInputLog:(NSString *)log;

-(NSString *)userId;

//点击购物车
-(void)showCartViewInNavigationController:(UINavigationController *)rootNavi;

@end

@interface QSClient : NSObject

+(void)setConfigeration:(QSClientConfigeration *)configeration;
+(void)addDelegate:(id<QSClientDelegate>)delegate;
+(void)removeDelegate:(id<QSClientDelegate>)delegate;

+(UIViewController *)instancedOrganizerViewController;

@end

@interface QSClient (Private)
@property (nonatomic , strong , readonly) QSClientConfigeration *configeration;
+(void)logInfo:(NSString *)format, ...;
+(instancetype)sharedInstance;
+(NSString *)userId;
+(void)showCartInNavi:(UINavigationController *)controller;
@end

NS_ASSUME_NONNULL_END
