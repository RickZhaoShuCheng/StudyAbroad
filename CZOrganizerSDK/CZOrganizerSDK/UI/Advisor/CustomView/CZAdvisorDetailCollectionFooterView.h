//
//  CZAdvisorDetailCollectionFooterView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZAdvisorDetailCollectionFooterView : UICollectionReusableView
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,copy) dispatch_block_t allBtnBlock;
@end

NS_ASSUME_NONNULL_END
