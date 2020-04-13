//
//  CZCommentsListVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZCommentsListVC : UIViewController
@property (nonatomic ,strong) NSString *idStr;
@property (nonatomic ,strong) NSString *commentsType;//1.机构 2.顾问 3.达人 4.商品
@end

NS_ASSUME_NONNULL_END
