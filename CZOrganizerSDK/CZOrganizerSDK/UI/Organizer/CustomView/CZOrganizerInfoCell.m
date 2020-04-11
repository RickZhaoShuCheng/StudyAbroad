//
//  CZOrganizerInfoCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerInfoCell.h"
#import "CZOrganizerInfoImgCell.h"

@interface CZOrganizerInfoCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;
@end
@implementation CZOrganizerInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initWithUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.type == 0) {
        return self.businessImgs.count;
    }else if (self.type == 1){
        return self.honorImgs.count;
    }else if (self.type == 2){
        return self.envImgs.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerInfoImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZOrganizerInfoImgCell class]) forIndexPath:indexPath];
    if (self.type == 0) {
        cell.imgUrl = PIC_URL(self.businessImgs[indexPath.row]);
    }else if (self.type == 1){
        cell.imgUrl = PIC_URL(self.honorImgs[indexPath.row]);
    }else if (self.type == 2){
        cell.imgUrl = PIC_URL(self.envImgs[indexPath.row]);
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        return CGSizeMake(ScreenScale(220), ScreenScale(165));
    }
    return CGSizeMake(ScreenScale(175), ScreenScale(175));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, ScreenScale(30), 0, ScreenScale(30));
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(27, 27, 27, 1);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CZOrganizerInfoImgCell class] forCellWithReuseIdentifier:NSStringFromClass([CZOrganizerInfoImgCell class])];
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(ScreenScale(28));
        make.height.mas_equalTo(ScreenScale(175));
    }];
}
@end
