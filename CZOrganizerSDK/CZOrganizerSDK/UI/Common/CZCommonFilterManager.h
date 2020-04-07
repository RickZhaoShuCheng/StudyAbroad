//
//  CZCommonFilterManager.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropMenuBar.h"
#import "CZHomeParam.h"

typedef enum : NSUInteger {
    CZCommonFilterTypeCarefulyChoose,
    CZCommonFilterTypeDiary,
    CZCommonFilterTypeSchoolStar,
    CZCommonFilterTypeAdvisor,
    CZCommonFilterTypeOrganizer,
    
    CZCommonFilterTypeServiceThird,
    CZCommonFilterTypeServiceSchoolStar,
    CZCommonFilterTypeServiceDiary,
    
    CZCommonFilterTypeHomeCarefulyChoose,
    CZCommonFilterTypeHomeDiary,
    CZCommonFilterTypeHomeSchoolStar,
    CZCommonFilterTypeHomeAdvisor,
    CZCommonFilterTypeHomeOrganizer,
    
    CZCommonFilterTypeMoreSchoolStar,
    CZCommonFilterTypeMoreActivity,

} CZCommonFilterType;

NS_ASSUME_NONNULL_BEGIN

@interface CZCommonFilterManager : NSObject
@property (nonatomic , strong)CZHomeParam *param;
@property (nonatomic , strong)void(^selectBlock)(CZHomeParam *param);
@property (nonatomic , strong)void(^filterViewShow)(void);
-(DropMenuBar *)actionsForType:(CZCommonFilterType)filterType;
@end

NS_ASSUME_NONNULL_END
