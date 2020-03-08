//
//  QSCommonService.h
//  QSLoginSDK
//
//  Created by zsc on 2019/8/28.
//  Copyright © 2019 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    QSServiceTypeOrganizerHome,
} QSServiceType;

NS_ASSUME_NONNULL_BEGIN

@interface QSCommonService : NSObject

+(id)service:(QSServiceType)type;
/**
 * 删除Dictionary中的NSNull
 */
+ (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic;
/**
 * 删除NSArray中的NSNull
 */
+ (NSMutableArray *)removeNullFromArray:(NSArray *)arr;
@end

static inline id serviceByType(QSServiceType type)
{
    return [QSCommonService service:type];
}

NS_ASSUME_NONNULL_END
