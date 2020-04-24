//
//  CZAdvisorDetailEvaluateCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailEvaluateCell : UICollectionViewCell
@property (nonatomic ,strong)NSMutableArray *picsArr;
@property (nonatomic ,strong) CZCommentModel *model;
@property (nonatomic ,copy) void (^clickLikeAction)(UIButton * likeBtn) ;
@end

NS_ASSUME_NONNULL_END
