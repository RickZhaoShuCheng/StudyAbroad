//
//  OrganizerDynamicTableHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDynamicTableHeaderView : UIView
@property (nonatomic ,strong)UIImageView *bgImg;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong) CZOrganizerModel *model;
@property (nonatomic ,copy) void (^arrowBtnClick)(UIButton *button);
@end

NS_ASSUME_NONNULL_END
