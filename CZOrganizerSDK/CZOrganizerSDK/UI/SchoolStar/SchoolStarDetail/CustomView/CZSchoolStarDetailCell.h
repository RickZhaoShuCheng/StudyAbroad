//
//  SchoolStarDetailCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZSchoolStarDetailPostVC.h"
#import "CZSchoolStarDetailPiiicVC.h"
#import "CZSchoolStarDetailDiaryVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZSchoolStarDetailCell : UITableViewCell
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) CZSchoolStarDetailPostVC *postVC;
@property (nonatomic ,strong) CZSchoolStarDetailPiiicVC *piiicVC;
@property (nonatomic ,strong) CZSchoolStarDetailDiaryVC *diaryVC;
@property (nonatomic ,strong) UIViewController *superVC;
@property (nonatomic ,strong) NSString *userId;
/**
 * 滚动值
 */
@property (nonatomic,copy) void (^scrollContentSize)(CGFloat offsetY);
@end

NS_ASSUME_NONNULL_END
