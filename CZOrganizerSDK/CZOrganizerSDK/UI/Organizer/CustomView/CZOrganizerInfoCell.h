//
//  CZOrganizerInfoCell.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZOrganizerInfoCell : UITableViewCell
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,assign) NSInteger type;
@property (nonatomic ,strong) NSMutableArray *businessImgs;
@property (nonatomic ,strong) NSMutableArray *honorImgs;
@property (nonatomic ,strong) NSMutableArray *envImgs;
@end

NS_ASSUME_NONNULL_END
