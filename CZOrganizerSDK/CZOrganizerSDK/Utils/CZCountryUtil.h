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
@property (nonatomic , strong ,readonly) NSMutableArray *cities;
@property (nonatomic , strong ,readonly) NSMutableArray *provinces;
@property (nonatomic , strong) CZSCountryModel *selectModel;
+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
