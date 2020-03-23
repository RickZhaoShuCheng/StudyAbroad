//
//  CZBoardSchoolStarViewController.h
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/20.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZScrollContentControllerDeleagte.h"
#import "CZHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardSchoolStarViewController : UIViewController<CZScrollContentControllerDeleagte>
@property (nonatomic, strong) CZHomeModel *model;
@end

NS_ASSUME_NONNULL_END
