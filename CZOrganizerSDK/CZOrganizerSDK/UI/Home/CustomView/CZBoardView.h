//
//  CZBoardView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZBoardView : UIView

@property (nonatomic,strong,readonly)NSArray<CZHomeModel *> *boards;

@property (nonatomic,strong)void(^clickBlock)(CZHomeModel *);

- (instancetype)initWithBoards:(NSArray<CZHomeModel *> *)courses
                      container:(UIView *)container;

-(void)updateLayoutByBoards:(NSArray<CZHomeModel *> *)courses;

@end

NS_ASSUME_NONNULL_END
