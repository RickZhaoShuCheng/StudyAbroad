//
//  CZOrganizerProjectCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZProductVoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerProjectCollectionView : UICollectionView
@property (nonatomic ,strong) NSMutableArray *dataArr;
//点击服务项目
@property (nonatomic ,copy) void (^selectProductBlock)(CZProductVoListModel *model);
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
