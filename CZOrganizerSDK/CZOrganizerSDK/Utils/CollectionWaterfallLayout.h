//
//  CollectionWaterfallLayout.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/12.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSupplementaryViewKindHeader;

@protocol CollectionWaterfallLayoutProtocol;
@interface CZCollectionWaterfallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<CollectionWaterfallLayoutProtocol> delegate;
@property (nonatomic, assign) NSUInteger columns;
@property (nonatomic, assign) CGFloat columnSpacing;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets insets;

@end



@protocol CollectionWaterfallLayoutProtocol <NSObject>

- (CGFloat)collectionViewLayout:(CZCollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionViewLayout:(CZCollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;

@end
