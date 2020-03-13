//
//  CZBoardProductListView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardProductListView.h"
#import "CZBoardProductListCell.h"

@interface CZBoardProductListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CZBoardProductListView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[CZBoardProductListCell class] forCellWithReuseIdentifier:NSStringFromClass([CZBoardProductListCell class])];
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
    CZBoardProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZBoardProductListCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataArr[indexPath.row]];
    return cell;
}



@end
