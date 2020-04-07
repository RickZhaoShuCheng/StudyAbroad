//
//  CZMoreSchoolStarTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarModel.h"
#import "CZProductVoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZMoreSchoolStarTableView : UITableView
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) void (^selectedSchoolStarCell)(CZSchoolStarModel *model);
@property (nonatomic ,copy) void (^selectedProductCell)(CZProductVoListModel *model);
@end

NS_ASSUME_NONNULL_END
