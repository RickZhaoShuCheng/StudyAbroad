//
//  ExperienceView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExperienceView : UIView
@property (nonatomic ,assign) BOOL isEnd;
@property (nonatomic ,strong) CZSportEduModel *model;
@end

NS_ASSUME_NONNULL_END
