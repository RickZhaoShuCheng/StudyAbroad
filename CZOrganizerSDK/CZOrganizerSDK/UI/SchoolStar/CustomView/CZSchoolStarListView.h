//
//  CZSchoolStarListView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarModel.h"
#import "CZProductVoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarListView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) void (^selectedSchoolStarCell)(CZSchoolStarModel *model);
@property (nonatomic ,copy) void (^selectedProductCell)(CZProductVoListModel *model);
@end

NS_ASSUME_NONNULL_END
