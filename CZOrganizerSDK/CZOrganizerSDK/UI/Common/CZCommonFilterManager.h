//
//  CZCommonFilterManager.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropMenuBar.h"


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

} CZCommonFilterType;

NS_ASSUME_NONNULL_BEGIN

@interface CZCommonFilterManager : NSObject

-(DropMenuBar *)actionsForType:(CZCommonFilterType)filterType;

@end

NS_ASSUME_NONNULL_END
