//
//  CXSearchCollectionReusableView.h
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXSearchCollectionReusableView;

@protocol UICollectionReusableViewButtonDelegate<NSObject>

- (void)deleteDatas:(CXSearchCollectionReusableView *)view;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CXSearchCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) id<UICollectionReusableViewButtonDelegate> delegate;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL hidenDeleteBtn;

@end

NS_ASSUME_NONNULL_END
