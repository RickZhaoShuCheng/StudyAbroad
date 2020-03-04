//
//  CZServiceView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CZServiceView;

@protocol CZServiceViewDelegate <NSObject>

-(void)serviceViewDidScroll:(NSInteger)pageIndex;

@end

@interface CZServiceView : UICollectionView

@property (nonatomic , strong) NSMutableArray *datas;

@property (nonatomic , weak) id<CZServiceViewDelegate> czDelegate;

@end

NS_ASSUME_NONNULL_END
