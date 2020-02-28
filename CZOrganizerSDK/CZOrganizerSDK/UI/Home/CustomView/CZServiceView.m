//
//  CZServiceView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZServiceView.h"
#import "CZServiceCell.h"
#import "CZHomeModel.h"

@interface CZServiceView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CZServiceView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    UICollectionViewFlowLayout *nlayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/4.0;
    nlayout.itemSize = CGSizeMake(itemWidth,70);
    nlayout.minimumLineSpacing = 0;
    nlayout.minimumInteritemSpacing = 0;
    nlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout = nlayout;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[CZServiceCell class] forCellWithReuseIdentifier:NSStringFromClass([CZServiceCell class])];
        self.pagingEnabled = YES;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
#pragma mark ----------UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZServiceCell class]) forIndexPath:indexPath];
    CZHomeModel *model = self.datas[indexPath.row];
    [cell setModel:model];
    return cell;
}


@end
