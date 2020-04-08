//
//  CZOrganizerDiaryCollectionView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerDiaryHeaderView.h"
#import "CZDiaryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDiaryCollectionView : UICollectionView
@property (nonatomic ,strong) CZOrganizerDiaryHeaderView *headerView;
- (void)setTagListTags:(NSMutableArray *)tagsArr;
@property (nonatomic ,strong) NSMutableArray *dataArr;
/**
 * 选择日记筛选index
 */
@property (nonatomic,copy) void (^selectDiaryIndex)(NSInteger index);
//点击日记
@property (nonatomic ,copy) void (^selectDiaryBlock)(CZDiaryModel *model);
@end

NS_ASSUME_NONNULL_END
