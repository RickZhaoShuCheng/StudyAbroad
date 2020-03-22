//
//  CZAdvisorDetailService.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CZAdvisorDetailBack)(BOOL success , NSInteger code ,id data ,NSString *errorMessage);
@interface CZAdvisorDetailService : NSObject
/**
 *获取顾问详情
 *counselorId 顾问id
 */
-(void)requestForApiCounselorGetCounselorDetails:(NSString *)counselorId callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取顾问下的服务项目
 *counselorId 顾问id
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductGetCounselorRecommendProduct:(NSString *)counselorId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取顾问下的日记
 *caseType 1.机构 2.顾问 3.达人 4.商品
 *id 查询的类型id
 *filterSum 过滤条件 1 全部 2 最新 3.尽心尽责 4 有视频 5 值得信赖
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiDiaryFindCaseListByFilter:(NSString *)caseType idStr:(NSString *)idStr filterSum:(NSInteger)filterSum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取评价
 *commentsType 1.机构 2.顾问 3.达人 4.商品
 *id 查询的类型id
 *filterSum 过滤条件 智能排序
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiObjectCommentsFindComments:(NSString *)commentsType idStr:(NSString *)idStr filterSum:(NSInteger)filterSum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
@end

NS_ASSUME_NONNULL_END
