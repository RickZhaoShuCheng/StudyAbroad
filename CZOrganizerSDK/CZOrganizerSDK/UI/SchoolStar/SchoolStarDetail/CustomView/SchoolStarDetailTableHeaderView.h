//
//  SchoolStarDetailTableHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarDetailTableHeaderView : UIView
@property (nonatomic ,strong)UIImageView *bgImg;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong) UIView *experienceContainerView;
@property (nonatomic ,strong) UIImageView *arrowImg;
@property (nonatomic ,strong) CZSchoolStarModel *model;
@property (nonatomic ,copy) void (^arrowBtnClick)(UIButton *button);
@property (nonatomic ,copy) void (^moreBtnClick)(UIButton *button);
@end

NS_ASSUME_NONNULL_END
