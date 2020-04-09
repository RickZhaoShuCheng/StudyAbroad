//
//  CXSearchModel.h
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXSearchProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXSearchModel : NSObject <CXSearchProtocol>

- (instancetype)initWithName:(NSString *)name searchId:(NSString *)searchId;

@end

NS_ASSUME_NONNULL_END
