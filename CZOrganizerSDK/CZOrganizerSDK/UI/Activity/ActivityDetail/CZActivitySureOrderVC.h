//
//  CZActivitySureOrderVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/17.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZActivitySureOrderVC : UIViewController
@property (nonatomic ,strong) NSDictionary *dic;
@property (nonatomic ,copy) dispatch_block_t sureCallBack;
@end

NS_ASSUME_NONNULL_END
