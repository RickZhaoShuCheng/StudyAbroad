//
//  CZCarefullyChooseViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCarefullyChooseViewController.h"

@interface CZCarefullyChooseViewController ()

@property (nonatomic ,strong) UICollectionView *dataCollectionView;

@end

@implementation CZCarefullyChooseViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.dataCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.dataCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dataCollectionView];
    self.contentScrollView = self.dataCollectionView;
    self.dataCollectionView.alwaysBounceVertical = YES;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.dataCollectionView.frame = self.view.bounds;
}

@end
