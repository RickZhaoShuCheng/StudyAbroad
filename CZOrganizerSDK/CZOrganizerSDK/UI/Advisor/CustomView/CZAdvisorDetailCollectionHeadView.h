//
//  CZAdvisorDetailCollectionHeadView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailCollectionHeadView : UICollectionReusableView
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *contentStr;
@property (nonatomic ,strong)JCTagListView *tagList;
@property (nonatomic ,copy) dispatch_block_t allBtnBlock;

//设置标签
- (void)setTags:(NSMutableArray *)tagesArr;
@end

NS_ASSUME_NONNULL_END
