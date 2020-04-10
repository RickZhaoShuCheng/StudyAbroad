//
//  CZBoardProductViewController.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"
#import "CZHomeModel.h"

typedef enum : NSUInteger {
    CZBoardProductTypePopular,
    CZBoardProductTypeHot,
    CZBoardProductTypeGood,
    CZBoardProductTypeInteractive,
} CZBoardProductType;

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardProductViewController : UIViewController<CZScrollContentControllerDeleagte>
@property (nonatomic , assign) CZBoardProductType type;
@property (nonatomic, strong) CZHomeModel *model;
@end

NS_ASSUME_NONNULL_END
