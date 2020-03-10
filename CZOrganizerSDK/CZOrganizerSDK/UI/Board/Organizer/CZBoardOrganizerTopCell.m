//
//  CZBoardOrganizerTopCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/9.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardOrganizerTopCell.h"
#import "CZRankView.h"

@interface CZBoardOrganizerTopCell()
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *goldImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) CZRankView *rankView;

@end

@implementation CZBoardOrganizerTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width-30, 0)];
    [self.contentView addSubview:self.bgView];
    
    self.goldImageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.goldImageView];
    self.goldImageView.frame = CGRectMake(13, 13, 28, 31);
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.goldImageView.frame), 300, 1000, 20);
    self.nameLabel.center = CGPointMake(self.nameLabel.center.x, self.goldImageView.center.y);
    
    self.rankView = [CZRankView instanceRankViewByRate:3];
    self.rankView.frame = CGRectMake(CGRectGetMinX(self.goldImageView.frame), CGRectGetMaxY(self.goldImageView.frame)+8, 80, 12);
    [self.bgView addSubview:self.rankView];
    
    
}

@end
