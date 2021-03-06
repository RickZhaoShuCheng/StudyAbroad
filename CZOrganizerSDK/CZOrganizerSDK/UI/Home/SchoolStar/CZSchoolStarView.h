//
//  CZSchoolStarView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarView : UICollectionView

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) void (^selectedSchoolStarCell)(CZSchoolStarModel *model);
@end

NS_ASSUME_NONNULL_END
