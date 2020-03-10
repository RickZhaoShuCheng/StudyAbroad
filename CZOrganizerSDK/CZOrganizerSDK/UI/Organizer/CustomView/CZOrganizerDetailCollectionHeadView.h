//
//  CZOrganizerDetailCollectionHeadView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailCollectionHeadView : UICollectionReusableView
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *contentStr;
@property (nonatomic ,strong)JCTagListView *tagList;
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr;
@end

NS_ASSUME_NONNULL_END
