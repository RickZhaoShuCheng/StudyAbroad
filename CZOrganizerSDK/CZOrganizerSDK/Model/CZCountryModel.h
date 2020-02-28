//
//  CZCountryModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/27.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZCountryModel : NSObject

@property (nonatomic , strong) NSString *ID;
@property (nonatomic , strong) NSString *area_name;
@property (nonatomic , strong) NSString *pid;
@property (nonatomic , strong) NSString *level;
@property (nonatomic , strong) NSString *code;
@property (nonatomic , strong) NSString *language_code;
@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *lng;
@property (nonatomic , strong) NSString *hot;

@end

NS_ASSUME_NONNULL_END
