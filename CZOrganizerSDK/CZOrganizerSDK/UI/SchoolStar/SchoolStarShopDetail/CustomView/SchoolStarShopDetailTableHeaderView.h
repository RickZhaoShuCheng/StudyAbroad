//
//  SchoolStarShopDetailTableHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
#import "CZSchoolStarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarShopDetailTableHeaderView : UIView
@property (nonatomic ,strong)UIImageView *bgImg;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)JCTagListView *tagList;
@property (nonatomic ,strong)CZSchoolStarModel *model;
@property (nonatomic ,copy) dispatch_block_t locationClick;
@property (nonatomic ,copy) dispatch_block_t dynamicClick;
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr;
@end

NS_ASSUME_NONNULL_END
