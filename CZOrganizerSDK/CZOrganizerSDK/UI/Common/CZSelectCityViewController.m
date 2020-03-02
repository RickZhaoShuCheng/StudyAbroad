//
//  CZSelectCityViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSelectCityViewController.h"
#import "CZCitySelectView.h"

@interface CZSelectCityViewController ()
@property (nonatomic , strong) CZCitySelectView *selectView;
@end

@implementation CZSelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectView = [[CZCitySelectView alloc] initWithAction:nil];
    [self.selectView showInView:self.view];
}

@end
