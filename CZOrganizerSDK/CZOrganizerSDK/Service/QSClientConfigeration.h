//
//  QSClientConfigeration.h
//  QSLoginSDK
//
//  Created by zsc on 2019/9/17.
//  Copyright © 2019 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSClientConfigeration : NSObject
@property (nonatomic , assign) BOOL enableLog;//默认输出
@property (nonatomic , copy , readonly) NSString *baseURL;
@property (nonatomic , copy , readonly) NSDictionary *headers;
@end
