//
//  CZOrganizerInfoView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZOrganizerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerInfoView : UIView
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) CZOrganizerModel *model;
//点击折叠
@property (nonatomic ,copy) dispatch_block_t clickFoldBtnBlock;
@end

NS_ASSUME_NONNULL_END
