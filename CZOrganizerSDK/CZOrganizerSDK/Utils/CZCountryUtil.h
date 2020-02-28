//
//  CZCountryUtil.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZSCountryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZCountryUtil : NSObject
@property (nonatomic , strong ,readonly) NSMutableArray<CZSCountryModel*> *datas;
+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
