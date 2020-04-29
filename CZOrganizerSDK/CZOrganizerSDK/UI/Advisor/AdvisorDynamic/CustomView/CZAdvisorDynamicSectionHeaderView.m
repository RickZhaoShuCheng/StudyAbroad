//
//  AdvisorDynamicSectionHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicSectionHeaderView.h"

@interface CZAdvisorDynamicSectionHeaderView()<SPPageMenuDelegate>

@end
@implementation CZAdvisorDynamicSectionHeaderView

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
    
    NSArray *menuArr = @[@"文章",@"问答"];
    // trackerStyle:跟踪器的样式
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(ScreenScale(100), 0, kScreenWidth-ScreenScale(200), ScreenScale(89)) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    self.pageMenu.selectedItemTitleColor = CZColorCreater(54,163, 238, 1);
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(51, 51, 51, 1);
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:ScreenScale(34)];
    self.pageMenu.tracker.backgroundColor = CZColorCreater(54, 163, 238, 1);
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
