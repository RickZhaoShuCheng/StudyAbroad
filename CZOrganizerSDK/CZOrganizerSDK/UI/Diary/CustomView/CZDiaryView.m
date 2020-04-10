//
//  CZDiaryView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZDiaryView.h"
#import "CZDiaryCell.h"
#import "QSClient.h"

@interface CZDiaryView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CZDiaryView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CZDiaryCell class] forCellWithReuseIdentifier:NSStringFromClass([CZDiaryCell class])];
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
    CZDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZDiaryCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataArr[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CZDiaryModel *model = self.dataArr[indexPath.row];
    UIViewController *controller = [QSClient instanceDiaryDetailTabVCByOptions:@{@"diaryId":model.smdId}];
    controller.hidesBottomBarWhenPushed = YES;
    [self.superVC.navigationController pushViewController:controller animated:YES];
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
