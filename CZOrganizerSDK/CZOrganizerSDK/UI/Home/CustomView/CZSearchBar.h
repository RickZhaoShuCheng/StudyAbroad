//
//  CZSearchBar.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZSearchBar : UIView

-(void)setEditTextChangedListener:(void(^)(NSString *text))block;

-(void)setSearchAction:(void(^)(void))block;

-(void)enableEdit:(BOOL)edit;

-(void)setSearchStartAction:(void(^)(NSString *text))block;

@end

NS_ASSUME_NONNULL_END
