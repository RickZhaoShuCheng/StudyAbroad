//
//  CXSearchCollectionReusableView.m
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import "CXSearchCollectionReusableView.h"

@interface CXSearchCollectionReusableView()

@property (weak,nonatomic) UILabel *textLabel;

@property (weak,nonatomic) UIImageView *imageView;

@property (weak,nonatomic) UIButton *delectButton;

@end

@implementation CXSearchCollectionReusableView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(18.0f, (self.frame.size.height - 18.0f / 2), 18, 18)];
//    [self addSubview:imageView];
//    self.imageView = imageView;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.frame.size.height - 18.0f / 2), 100.0f, 18)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:label];
    self.textLabel = label;
    
    UIButton *delectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 65, (self.frame.size.height - 30.0f / 2), 65, 30)];
    [delectButton setImage:[CZImageProvider imageNamed:@"shan_chu"] forState:UIControlStateNormal];
    [delectButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delectButton];
    _delectButton = delectButton;
}

- (void)deleteClick {
    if ([self.delegate respondsToSelector:@selector(deleteDatas:)]) {
        [self.delegate deleteDatas:self];
    }
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.textLabel.text = text;
}

- (void)setHidenDeleteBtn:(BOOL)hidenDeleteBtn {
    _hidenDeleteBtn = hidenDeleteBtn;
    self.delectButton.hidden = _hidenDeleteBtn;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}

@end
