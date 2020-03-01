//
//  QSOrganizerHomeService.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZHomeParam.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSOrganizerHomeBack)(BOOL success , NSInteger code ,id data ,NSString *errorMessage);

@interface QSOrganizerHomeService : NSObject

//首页地区---查询全部地区
-(void)requestForApiPlaceholderFindPlaceholderMapBySpType:(NSNumber*)spType callBack:(QSOrganizerHomeBack)callBack;

//首页-推荐达人 
-(void)requestForApiSportUserGetHomePageSportUser:(NSString*)userId
                                         callBack:(QSOrganizerHomeBack)callBack;

//活动---查询热门活动
-(void)requestForapiProductActivitySelectHotProductActivityByUserId:(NSString*)userId
                                                            pageNum:(NSNumber*)pageNum
                                                           pageSize:(NSNumber*)pageSize
                                                           callBack:(QSOrganizerHomeBack)callBack;
//首页-获取精选的商品
-(void)requestForApiProductGetDefaultProductListByParam:(CZHomeParam *)param
                                               callBack:(QSOrganizerHomeBack)callBack;

//首页口碑和分类标签----筛选日记
-(void)requestForApiDiaryFindAllCaseListByParam:(CZHomeParam *)param
                                       callBack:(QSOrganizerHomeBack)callBack;

//首页-筛选达人列表数据
-(void)requestForApiSportUserGetSportUserListByFilterByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack;

//首页-筛选顾问列表数据
-(void)requestForApiCounselorGetCounselorListByFilterByParam:(CZHomeParam *)param
                                                    callBack:(QSOrganizerHomeBack)callBack;

//首页-筛选机构列表数据
-(void)requestForApiOrganGetOrganListByFilterByParam:(CZHomeParam *)param
                                            callBack:(QSOrganizerHomeBack)callBack;
@end

NS_ASSUME_NONNULL_END
