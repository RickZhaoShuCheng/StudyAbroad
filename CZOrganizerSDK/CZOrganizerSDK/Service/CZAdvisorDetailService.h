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
 *获取机构下的服务项目
 *organId 机构id
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductGetOrganRecommendProduct:(NSString *)organId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取机构下的顾问
 *organId 机构id
 */
-(void)requestForApiCounselorGetCounselorListByOrganId:(NSString *)organId callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取评价
 *commentsType 1.机构 2.顾问 3.达人 4.商品
 *id 查询的类型id
 *filterSum 过滤条件 智能排序
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiObjectCommentsFindComments:(NSString *)commentsType idStr:(NSString *)idStr filterSum:(NSInteger)filterSum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取评价详情
 *socId 评价id
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiObjectCommentsFindObjectCommentsBySocId:(NSString *)socId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取商品信息
 *productId 商品id
 */
-(void)requestForApiProductGetProductDetail:(NSString *)productId callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取活动详情
 *productId 商品id
 */
-(void)requestForApiProductActivitySelectProductActivityInfo:(NSString *)productId callBack:(CZAdvisorDetailBack)callBack;
/**
 *筛选查询活动
 *filterDic 筛选条件
 *pageNum 页数
 *pageSize 每页条数
 */
-(void)requestForApiProductActivitySelectProductActivityByFilter:(NSDictionary *)filterDic pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取推荐活动
 *productCategory 活动详情中的productCategory
 *productActivityId 当前活动详情中的productActivityId
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductActivitySelectRecommendProductActivityList:(NSString *)productCategory productActivityId:(NSString *)productActivityId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取达人店铺详情
 *sportUserId 达人用户id
 */
-(void)requestForApiSportUserSelectSportUserInfo:(NSString *)sportUserId callBack:(CZAdvisorDetailBack)callBack;
/**
 *获取机构、顾问、达人的商品
 *productType 商品归属（1.机构 2.顾问 3.达人）
 *idStr 归属id（例：机构id）
 *pageNum 页
 *pageSize 数
 */
-(void)requestForApiProductGetProductList:(NSString *)productType idStr:(NSString *)idStr pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(CZAdvisorDetailBack)callBack;

/**
 *点赞---评论点赞
 *socId 评价id
 */
-(void)requestForApiObjectCommentsPraiseObjectCommentsPraise:(NSString *)socId callBack:(CZAdvisorDetailBack)callBack;
/**
 *取消点赞---评论取消点赞
 *socId 评价id
 */
-(void)requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:(NSString *)socId callBack:(CZAdvisorDetailBack)callBack;
/**
 *添加关注
 *ffUserId  关注人id
 */
-(void)requestForApiFocusFanSaveFocusFan:(NSString *)ffUserId  callBack:(CZAdvisorDetailBack)callBack;
/**
 *取消关注
 *ffUserId  关注人id
 */
-(void)requestForApiFocusFanCancelFocusFan:(NSString *)ffUserId  callBack:(CZAdvisorDetailBack)callBack;
/**
 *收藏
 *collectContentId  收藏对象id
 *collectType 收藏类型 1.普通动态 2.话题动态 4日记 5普通长图文 6话题长图文 7商品 8活动 9达人 10机构 11 顾问
 */
-(void)requestForApiCollectCollect:(NSString *)collectContentId collectType:(NSInteger)collectType callBack:(CZAdvisorDetailBack)callBack;
/**
 *取消收藏
 *collectContentId  收藏对象id
 *collectType 收藏类型（5.商品 6.机构 7.达人8.顾问
 */
-(void)requestForApiCollectCancelCollect:(NSString *)collectContentId collectType:(NSInteger)collectType callBack:(CZAdvisorDetailBack)callBack;
@end

NS_ASSUME_NONNULL_END
