//
//  CZOrganizerDetailCollectionFooterView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerDetailCollectionFooterView : UICollectionReusableView
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,copy) dispatch_block_t allBtnBlock;
@end

NS_ASSUME_NONNULL_END
