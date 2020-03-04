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

@interface CZServiceFlowLayout : UICollectionViewFlowLayout
@property (nonatomic , assign) NSInteger rowCount;
@property (nonatomic , assign) NSInteger columnCount;
@property (nonatomic , strong) NSMutableArray *allAttributes;

@end

@implementation CZServiceFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.rowCount = 2;
    self.columnCount = 4;
    
    self.allAttributes = [[NSMutableArray alloc] init];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *array = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:array];
    }
    
}

-(CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

// 计算itemframe
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger item = indexPath.item;
    // 总页数
    NSInteger pageNumber = item / (self.rowCount * self.columnCount);
    // 该页中item的序号
    NSInteger itemInPage = item % (self.rowCount * self.columnCount);
    // item的所在列、行
    NSInteger col = itemInPage % self.columnCount;
    NSInteger row = itemInPage / self.columnCount;
    
    CGFloat x = self.sectionInset.left + (self.itemSize.width + self.minimumInteritemSpacing)*col + pageNumber * self.collectionView.bounds.size.width;
    CGFloat y = self.sectionInset.top + (self.itemSize.height + self.minimumLineSpacing)*row ;
    
    attri.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
  
    return attri;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (UICollectionViewLayoutAttributes *layout1 in layoutArray) {
        for (UICollectionViewLayoutAttributes *layout2 in self.allAttributes) {
            if (layout1.indexPath.item == layout2.indexPath.item) {
                [tmp addObject:layout2];
                break;
            }
        }
    }
    return tmp;
}

@end

@interface CZServiceView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@end

@implementation CZServiceView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    CZServiceFlowLayout *nlayout = [[CZServiceFlowLayout alloc]init];
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
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.czDelegate && [self.czDelegate respondsToSelector:@selector(serviceViewDidScroll:)]) {
        NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
        [self.czDelegate serviceViewDidScroll:pageIndex];
    }
}
@end
