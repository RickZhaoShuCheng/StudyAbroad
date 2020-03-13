//
//  CZOrganizerDetailViewController.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerDetailCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailViewController : UIViewController
@property (nonatomic ,strong)CZOrganizerDetailCollectionView *collectionView;
@property (nonatomic ,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
