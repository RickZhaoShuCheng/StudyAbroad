//
//  CZCommentsListTableView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZCommentsListTableView : UITableView
- (void)setTagListTags:(NSMutableArray *)tagsArr;
@property (nonatomic ,strong)NSMutableArray *commentsArr;
@property (nonatomic ,copy) dispatch_block_t selectedBlock;
@end

NS_ASSUME_NONNULL_END
