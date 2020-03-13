//
//  CZOrganizerDiaryHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDiaryHeaderView : UICollectionReusableView
@property (nonatomic ,strong) JCTagListView *tagList;
@property (nonatomic ,strong) UIButton *arrowBtn;
@end

NS_ASSUME_NONNULL_END
