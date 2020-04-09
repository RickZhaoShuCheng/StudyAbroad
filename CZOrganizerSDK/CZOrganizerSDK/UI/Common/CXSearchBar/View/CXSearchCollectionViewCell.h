//
//  CXSearchCollectionViewCell.h
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSearchCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *text;

+ (CGSize)getSizeWithText:(NSString*)text;

@end

