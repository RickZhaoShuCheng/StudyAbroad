//
//  CZCommonInstance.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZCommonInstance : NSObject

@property (nonatomic , strong) NSMutableArray<CZHomeModel *> *servies;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
