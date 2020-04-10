//
//  SchoolStarShopCaseVC.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarShopCaseCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopCaseVC : UIViewController
@property (nonatomic ,strong) SchoolStarShopCaseCollectionView *collectionView;
@property (nonatomic ,strong) NSString *sportUserId;
@property (nonatomic ,strong) UIViewController *superVC;
@end

NS_ASSUME_NONNULL_END
