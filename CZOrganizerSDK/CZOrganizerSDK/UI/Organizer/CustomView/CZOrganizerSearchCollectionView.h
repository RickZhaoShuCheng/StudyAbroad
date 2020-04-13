//
//  CZOrganizerSearchCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerSearchCollectionView : UICollectionView
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) void (^selectSearchKey)(NSString *key);
@end

NS_ASSUME_NONNULL_END
