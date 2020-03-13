//
//  CZOrganizerDetailHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailHeaderView : UICollectionReusableView
@property (nonatomic ,strong)UIImageView *bgImg;
//存放营业执照的容器
@property (nonatomic ,strong)UIView *containerView;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)JCTagListView *tagList;
@property (nonatomic ,strong)SDCycleScrollView *scrollDynamic;
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr;
@end

NS_ASSUME_NONNULL_END