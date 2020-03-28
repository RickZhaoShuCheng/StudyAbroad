//
//  CZOrganizerDiaryCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerDiaryHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDiaryCollectionView : UICollectionView
@property (nonatomic ,strong) CZOrganizerDiaryHeaderView *headerView;
- (void)setTagListTags:(NSMutableArray *)tagsArr;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end

NS_ASSUME_NONNULL_END
