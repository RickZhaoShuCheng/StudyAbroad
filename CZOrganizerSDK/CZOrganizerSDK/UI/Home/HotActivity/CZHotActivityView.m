//
//  CZHotActivityView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZHotActivityView.h"
#import "CZHotActivityCell.h"
#import "CZActivityModel.h"

@interface CZHotActivityView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CZHotActivityView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[CZHotActivityCell class] forCellWithReuseIdentifier:NSStringFromClass([CZHotActivityCell class])];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark ----------UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZHotActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZHotActivityCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataArr[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CZActivityModel *model = self.dataArr[indexPath.row];
    if (self.selectedBlock) {
        self.selectedBlock(model.productActivityId);
    }
}


@end
