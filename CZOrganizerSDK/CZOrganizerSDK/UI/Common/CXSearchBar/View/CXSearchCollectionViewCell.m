//
//  CXSearchCollectionViewCell.m
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import "CXSearchCollectionViewCell.h"
#import "CXSearchViewController.h"

@interface CXSearchCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CXSearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.backView.layer setCornerRadius:4.0];
    [self.backView setBackgroundColor:CZColorCreater(244, 244, 248, 1.0)];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.nameLabel.text = text;
}

+ (CGSize)getSizeWithText:(NSString*)text {
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    if (size.width + 2*8 >= [UIScreen mainScreen].bounds.size.width - 2 *kFirstitemleftSpace) {
        size.width = [UIScreen mainScreen].bounds.size.width - 2 *kFirstitemleftSpace - 2*8.f;
    }
    return CGSizeMake(ceilf(size.width+2*8), 24);
}

@end
