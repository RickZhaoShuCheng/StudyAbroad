//
//  CZHomeFilterView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPageMenu.h"

@class DropMenuBar;
@class CZHomeFilterView;


NS_ASSUME_NONNULL_BEGIN

@protocol CZHomeFilterViewDelegate <NSObject>

-(void)filterView:(CZHomeFilterView *)filterView itemSelectedAtIndex:(NSInteger)index;

@end

@interface CZHomeFilterView : UIView

- (instancetype)initWithSuperView:(UIView *)superView;

@property (nonatomic , strong ,readonly) SPPageMenu *pageMenu;

@property (nonatomic) BOOL isTop;

@property (nonatomic, strong , readonly) DropMenuBar *menuScreeningView;

@property (nonatomic, assign) id<CZHomeFilterViewDelegate> delegate;

-(void)setRelateScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
