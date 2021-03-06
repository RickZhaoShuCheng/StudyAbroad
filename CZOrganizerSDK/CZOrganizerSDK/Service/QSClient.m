//
//  QSClient.m
//  QSLoginSDK
//
//  Created by zsc on 2019/8/28.
//  Copyright © 2019 zsc. All rights reserved.
//

#import "QSClient.h"
#import "QSClientConfigeration.h"
#import "CZOrganizerHomeViewController.h"
#import "CZOrganizerVC.h"
#import "CZCommentsListVC.h"
#import "CZOrganizerDiaryVC.h"
#import "CZAdvisorDetailViewController.h"
#import "CZSchoolStarShopDetailVC.h"
@interface QSClient ()

@property (nonatomic , strong) QSClientConfigeration *configeration;
@property (nonatomic , weak) id<QSClientDelegate> delegate;

@end

static QSClient *_instance = nil;
static dispatch_once_t onceToken;

@implementation QSClient

+(instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(void)setConfigeration:(QSClientConfigeration *)configeration
{
    [QSClient sharedInstance].configeration = configeration;
}

-(QSClientConfigeration *)configeration
{
    if (!_configeration) {
        _configeration = [[QSClientConfigeration alloc] init];
    }
    return _configeration;
}

+(void)logInfo:(NSString *)format, ...
{
    if (![QSClient sharedInstance].configeration.enableLog) {
        return;
    }
    
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(clientLoginInputLog:)]) {
        va_list args;
        va_start(args, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *content = [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]], string];
        va_end(args);
        [client.delegate clientLoginInputLog:content];
    }
}

+(void)addDelegate:(id<QSClientDelegate>)delegate
{
    [QSClient sharedInstance].delegate = delegate;
}

+(void)removeDelegate:(id<QSClientDelegate>)delegate
{
    [QSClient sharedInstance].delegate = nil;
}

+(NSString *)userId
{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(userId)]) {
        return [client.delegate userId];
    }
    return @"-1";
}

+(void)showCartInNavi:(UINavigationController *)controller
{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(showCartViewInNavigationController:)]) {
        [client.delegate showCartViewInNavigationController:controller];
    }
}

+(UIViewController *)instancedOrganizerViewController
{
    return [[CZOrganizerHomeViewController alloc] init];
}

+(UIViewController *)instanceDiaryViewControllerByParam:(CZHomeParam *)param
{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceDiaryViewControllerByParam:)]) {
       return [client.delegate instanceDiaryViewControllerByParam:param];
    }
    
    return nil;
}

+(UIViewController *)instanceWebViewByOptions:(NSDictionary *)options
{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceWebViewByOptions:)]) {
       return [client.delegate instanceWebViewByOptions:options];
    }
    
    return nil;
}

+(UIViewController *)instanceProductDetailVCByOptions:(NSDictionary *)options
{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceProductDetailVCByOptions:)]) {
       return [client.delegate instanceProductDetailVCByOptions:options];
    }
    return nil;
}

+(UIViewController *)instanceDiaryDetailTabVCByOptions:(NSDictionary *)options;
{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceDiaryDetailTabVCByOptions:)]) {
       return [client.delegate instanceDiaryDetailTabVCByOptions:options];
    }
    return nil;
}
+(UIViewController *)instanceSureOrderTabVCByOptions:(NSDictionary *)options{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceSureOrderTabVCByOptions:)]) {
       return [client.delegate instanceSureOrderTabVCByOptions:options];
    }
    return nil;
}
+(UIViewController *)instanceLXDROrderTabVCByOptions:(NSDictionary *)options{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceLXDROrderTabVCByOptions:)]) {
       return [client.delegate instanceLXDROrderTabVCByOptions:options];
    }
    return nil;
}
+(UIViewController *)instancePhoneTabVC{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instancePhoneTabVC)]) {
       return [client.delegate instancePhoneTabVC];
    }
    return nil;
}
+(UIViewController *)instanceChatTabVCByOptions:(NSDictionary *)options{
    QSClient *client = [QSClient sharedInstance];
    if (client.delegate && [client.delegate respondsToSelector:@selector(instanceChatTabVCByOptions:)]) {
        return [client.delegate instanceChatTabVCByOptions:options];
    }
    return nil;
}

+(UIViewController *)instanceOragizerDetailViewControllerByOptions:(NSDictionary *)options
{
    CZOrganizerVC *organizerVC = [[CZOrganizerVC alloc]init];
    organizerVC.organId = options[@"organId"];
    return organizerVC;
}

+(UIViewController *)instanceNiceCommentViewControllerByOptions:(NSDictionary *)options
{
    CZCommentsListVC *commentsList = [[CZCommentsListVC alloc]init];
    commentsList.idStr = options[@"organId"];
    commentsList.commentsType = options[@"commentsType"];
    return commentsList;
}

+(UIViewController *)instanceNiceDiaryViewControllerByOptions:(NSDictionary *)options
{
    CZOrganizerDiaryVC *diaryVC = [[CZOrganizerDiaryVC alloc]init];
    diaryVC.caseType = options[@"caseType"];
    diaryVC.idStr = options[@"organId"];
    return diaryVC;
}

+(UIViewController *)instanceAdvisorDetailViewControllerByOptions:(NSDictionary *)options
{
    CZAdvisorDetailViewController *advisorDetailVC = [[CZAdvisorDetailViewController alloc]init];
    advisorDetailVC.counselorId = options[@"counselorId"];
    return advisorDetailVC;
}
+(UIViewController *)instanceStarShopDetailViewControllerByOptions:(NSDictionary *)options
{
    CZSchoolStarShopDetailVC *detailVC = [[CZSchoolStarShopDetailVC alloc]init];
    detailVC.sportUserId = options[@"sportUserId"];
    return detailVC;
}

@end
