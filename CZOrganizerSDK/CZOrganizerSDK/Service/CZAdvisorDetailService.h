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
@end

NS_ASSUME_NONNULL_END
