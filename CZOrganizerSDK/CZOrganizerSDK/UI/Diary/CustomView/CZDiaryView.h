//
//  CZDiaryView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZDiaryView : UICollectionView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) UIViewController *superVC;

@end

NS_ASSUME_NONNULL_END
