//
//  CZCustomFilterView.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/30.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CZCustomFilteServiceTypeCash,
    CZCustomFilteServiceTypePayed,
} CZCustomFilteServiceType;

@interface CZCustomFilterModel : NSObject

@property (nonatomic , strong) NSNumber *type;

@property (nonatomic , strong) NSString *lowPrice;

@property (nonatomic , strong) NSString *highPrice;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CZCustomFilterView : UIView

@property (nonatomic , strong) void (^select)(CZCustomFilterModel *model);

-(void)layoutViews;

-(void)layoutPriceView:(UIView *)targetView;

@end

NS_ASSUME_NONNULL_END
