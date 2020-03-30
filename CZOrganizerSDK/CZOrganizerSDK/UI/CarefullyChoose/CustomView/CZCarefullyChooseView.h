//
//  CZCarefullyChooseView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZCarefullyChooseView : UICollectionView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) UIViewController *currentVC;

@end

NS_ASSUME_NONNULL_END
