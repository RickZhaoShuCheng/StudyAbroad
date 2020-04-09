//
//  CXSearchProtocol.h
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CXSearchProtocol <NSObject>

/**
 内容
 */
@property (nonatomic, copy) NSString *content;

/**
 搜索内容id
 */
@property (nonatomic, copy) NSString *searchId;

@end

NS_ASSUME_NONNULL_END
