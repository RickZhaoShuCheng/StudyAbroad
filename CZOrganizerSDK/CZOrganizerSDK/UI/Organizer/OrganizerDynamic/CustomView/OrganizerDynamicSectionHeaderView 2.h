//
//  OrganizerDynamicSectionHeaderView.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPageMenu.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrganizerDynamicSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic ,strong)SPPageMenu *pageMenu;
@end

NS_ASSUME_NONNULL_END
