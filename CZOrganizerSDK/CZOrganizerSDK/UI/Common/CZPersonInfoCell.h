//
//  CZPersionInfoCell.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZAdvisorModel;
@class CZOrganizerModel;


NS_ASSUME_NONNULL_BEGIN

@interface CZPersonInfoCell : UITableViewCell

@property (nonatomic , strong) CZAdvisorModel *model;
@property (nonatomic , strong) CZOrganizerModel *omodel;

@end

NS_ASSUME_NONNULL_END
