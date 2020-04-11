//
//  CZOrganizerInfoHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerInfoHeaderView : UIView
@property (nonatomic ,strong) CZOrganizerModel *model;
@property (nonatomic ,strong) UILabel *contentLab;
@end

NS_ASSUME_NONNULL_END
