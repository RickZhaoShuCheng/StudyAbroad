//
//  SchoolStarShopDetailSectionHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopDetailSectionHeaderView.h"
@interface SchoolStarShopDetailSectionHeaderView()<SPPageMenuDelegate>

@end
@implementation SchoolStarShopDetailSectionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    
    NSArray *menuArr = @[@"服务",@"评价",@"案例"];
    // trackerStyle:跟踪器的样式
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(89)) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    self.pageMenu.selectedItemTitleColor = CZColorCreater(0, 0, 0, 1);
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(140, 140, 153, 1);
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.pageMenu.tracker.backgroundColor = CZColorCreater(51, 172, 253, 1);
    // 传递数组，默认选中第0个
    [self.pageMenu setItems:menuArr selectedItemIndex:0];
    [self.contentView addSubview:self.pageMenu];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(238, 238, 242, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(1));
    }];
}

@end
