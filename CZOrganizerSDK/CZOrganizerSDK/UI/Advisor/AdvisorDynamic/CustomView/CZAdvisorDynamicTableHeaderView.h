//
//  AdvisorDynamicTableHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDynamicTableHeaderView : UIView
@property (nonatomic ,strong)UIImageView *bgImg;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong) CZUserInfoModel *model;
@property (nonatomic ,copy) void (^arrowBtnClick)(UIButton *button);
@property (nonatomic ,copy) dispatch_block_t clickChatBlock;
@end

NS_ASSUME_NONNULL_END
