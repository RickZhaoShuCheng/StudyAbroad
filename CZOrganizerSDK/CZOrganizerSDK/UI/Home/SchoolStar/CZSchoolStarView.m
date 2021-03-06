//
//  CZSchoolStarView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarView.h"
#import "CZSchoolStarCell.h"

@interface CZSchoolStarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CZSchoolStarView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[CZSchoolStarCell class] forCellWithReuseIdentifier:NSStringFromClass([CZSchoolStarCell class])];
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark ----------UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZSchoolStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZSchoolStarCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.selectedSchoolStarCell) {
        self.selectedSchoolStarCell(self.dataArr[indexPath.row]);
    }
}



@end
