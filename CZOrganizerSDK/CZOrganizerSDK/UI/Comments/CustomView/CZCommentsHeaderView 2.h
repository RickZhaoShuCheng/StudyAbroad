//
//  CZCommentsHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZCommentsHeaderView : UIView
@property (nonatomic ,strong) JCTagListView *tagList;
@property (nonatomic ,strong) UIButton *arrowBtn;
- (void)setVarStar:(NSNumber *)varStar;
- (void)setAvgMajor:(NSString *)avgMajor avgPrice:(NSString *)avgPrice avgService:(NSString *)avgService;
@end

NS_ASSUME_NONNULL_END
