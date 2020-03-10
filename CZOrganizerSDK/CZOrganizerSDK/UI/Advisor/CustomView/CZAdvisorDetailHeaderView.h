//
//  CZAdvisorDetailHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/4.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailHeaderView : UICollectionReusableView
@property (nonatomic ,strong)UIImageView *bgImg;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)JCTagListView *tagList;
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr;
@end

NS_ASSUME_NONNULL_END
