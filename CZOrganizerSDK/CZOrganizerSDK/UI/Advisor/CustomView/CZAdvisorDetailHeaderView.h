//
//  CZAdvisorDetailHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/4.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
#import "CZAdvisorInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailHeaderView : UICollectionReusableView
@property (nonatomic ,strong)UIImageView *bgImg;
@property (nonatomic ,strong)UIVisualEffectView *effectView;
@property (nonatomic ,strong)JCTagListView *tagList;
@property (nonatomic ,strong) CZAdvisorInfoModel *model;
@property (nonatomic ,copy) dispatch_block_t locationClick;
@property (nonatomic ,copy) dispatch_block_t dynamicClick;
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr;
@end

NS_ASSUME_NONNULL_END
