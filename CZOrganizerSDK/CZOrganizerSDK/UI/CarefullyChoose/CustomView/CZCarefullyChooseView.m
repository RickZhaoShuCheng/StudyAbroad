//
//  CZCarefullyChooseView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCarefullyChooseView.h"
#import "CZCarefullyChooseCell.h"
#import "QSClient.h"

@interface CZCarefullyChooseView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CZCarefullyChooseView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        [self registerClass:[CZCarefullyChooseCell class] forCellWithReuseIdentifier:NSStringFromClass([CZCarefullyChooseCell class])];
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
    CZCarefullyChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZCarefullyChooseCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataArr[indexPath.row]];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CZProductModel *model = self.dataArr[indexPath.row];
    UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
    prodDetailVC.hidesBottomBarWhenPushed = YES;
    [self.currentVC.navigationController pushViewController:prodDetailVC animated:YES];
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}



//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if([kind isEqualToString:@"Header"]){
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
//        
//        return headerView;
//    }
//    return nil;
//}


@end
