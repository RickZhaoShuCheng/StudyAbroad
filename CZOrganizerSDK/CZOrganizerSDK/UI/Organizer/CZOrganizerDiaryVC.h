//
//  CZOrganizerDiaryVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDiaryVC : UIViewController
@property (nonatomic ,strong) NSString *caseType;//1.机构 2.顾问 3.达人 4.商品
@property (nonatomic ,strong) NSString *idStr;//各类型id
@end

NS_ASSUME_NONNULL_END
