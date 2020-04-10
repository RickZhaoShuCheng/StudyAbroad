//
//  CZOrganizerSearchVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerSearchVC : UIViewController
@property (nonatomic ,strong) CZOrganizerModel *model;
@property (nonatomic ,copy) void (^callBackIsFocus)(BOOL isFocus);
@end

NS_ASSUME_NONNULL_END
