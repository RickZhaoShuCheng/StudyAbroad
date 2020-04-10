//
//  SchoolStarShopCaseCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/10.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopCaseCollectionView : UICollectionView
@property (nonatomic ,strong) NSMutableArray *dataArr;
//点击案例
@property (nonatomic ,copy) void (^selectCaseBlock)(CZCaseModel *model);
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
