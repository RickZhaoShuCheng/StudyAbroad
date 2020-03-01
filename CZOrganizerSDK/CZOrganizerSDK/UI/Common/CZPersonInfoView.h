//
//  CZPersonInfoView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRankView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZPersonInfoView : UIView

@property (nonatomic , strong ,readonly) UIImageView *avatarImageView;
@property (nonatomic , strong ,readonly) UILabel *infoLabel;
@property (nonatomic , strong ,readonly) UILabel *subTitleLabel;
@property (nonatomic , strong ,readonly) UILabel *organizeNameLabel;
@property (nonatomic , strong ,readonly) CZRankView *rankView;

- (instancetype)initWithFrame:(CGRect)frame container:(UIView *)container;

@end

NS_ASSUME_NONNULL_END
