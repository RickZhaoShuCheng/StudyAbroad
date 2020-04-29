//
//  ActivityDetailVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZActivityDetailVC : UIViewController
@property (nonatomic ,assign) BOOL isEnd;
@property (nonatomic ,assign) BOOL isFree;
@property (nonatomic ,strong) NSString *productId;
@end

NS_ASSUME_NONNULL_END
