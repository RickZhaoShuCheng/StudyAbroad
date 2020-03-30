//
//  CZCustomFilterView.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/30.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZCustomFilterModel : NSObject

@property (nonatomic , assign) BOOL isCash;

@property (nonatomic , assign) BOOL isPayed;

@property (nonatomic , assign) CGFloat lowPrice;

@property (nonatomic , assign) CGFloat highPrice;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CZCustomFilterView : UIView

@end

NS_ASSUME_NONNULL_END
