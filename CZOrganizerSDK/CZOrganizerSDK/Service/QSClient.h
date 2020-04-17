//
//  QSClient.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/28.
//  Copyright © 2019 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZHomeParam.h"

@class QSClientConfigeration;


NS_ASSUME_NONNULL_BEGIN

@protocol QSClientDelegate <NSObject>

-(void)clientLoginInputLog:(NSString *)log;

-(NSString *)userId;

//点击购物车
-(void)showCartViewInNavigationController:(UINavigationController *)rootNavi;

-(UIViewController *)instanceDiaryViewControllerByParam:(CZHomeParam *)param;

-(UIViewController *)instanceWebViewByOptions:(NSDictionary *)options;

-(UIViewController *)instanceProductDetailVCByOptions:(NSDictionary *)options;

-(UIViewController *)instanceDiaryDetailTabVCByOptions:(NSDictionary *)options;

-(UIViewController *)instanceSureOrderTabVCByOptions:(NSDictionary *)options;

-(UIViewController *)instancePhoneTabVC;

-(UIViewController *)instanceLXDROrderTabVCByOptions:(NSDictionary *)options;

-(void)instanceOragizerDetailViewController:(UINavigationController *)controller options:(NSDictionary *)options;

@end

@interface QSClient : NSObject

+(void)setConfigeration:(QSClientConfigeration *)configeration;
+(void)addDelegate:(id<QSClientDelegate>)delegate;
+(void)removeDelegate:(id<QSClientDelegate>)delegate;

+(UIViewController *)instancedOrganizerViewController;
+(UIViewController *)instanceOragizerDetailViewControllerByOptions:(NSDictionary *)options;
+(UIViewController *)instanceNiceCommentViewControllerByOptions:(NSDictionary *)options;
+(UIViewController *)instanceNiceDiaryViewControllerByOptions:(NSDictionary *)options;
+(UIViewController *)instanceAdvisorDetailViewControllerByOptions:(NSDictionary *)options;
@end

@interface QSClient (Private)
@property (nonatomic , strong , readonly) QSClientConfigeration *configeration;
+(void)logInfo:(NSString *)format, ...;
+(instancetype)sharedInstance;
+(NSString *)userId;
+(void)showCartInNavi:(UINavigationController *)controller;
+(UIViewController *)instanceDiaryViewControllerByParam:(CZHomeParam *)param;
+(UIViewController *)instanceWebViewByOptions:(NSDictionary *)options;
+(UIViewController *)instanceProductDetailVCByOptions:(NSDictionary *)options;
+(UIViewController *)instanceDiaryDetailTabVCByOptions:(NSDictionary *)options;
+(UIViewController *)instanceSureOrderTabVCByOptions:(NSDictionary *)options;
+(UIViewController *)instancePhoneTabVC;
+(UIViewController *)instanceLXDROrderTabVCByOptions:(NSDictionary *)options;
@end

NS_ASSUME_NONNULL_END
