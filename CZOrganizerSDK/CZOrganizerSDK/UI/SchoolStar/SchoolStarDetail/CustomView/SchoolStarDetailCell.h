//
//  SchoolStarDetailCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStarDetailPostVC.h"
#import "SchoolStarDetailPiiicVC.h"
#import "SchoolStarDetailDiaryVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolStarDetailCell : UITableViewCell
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) SchoolStarDetailPostVC *postVC;
@property (nonatomic ,strong) SchoolStarDetailPiiicVC *piiicVC;
@property (nonatomic ,strong) SchoolStarDetailDiaryVC *diaryVC;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
