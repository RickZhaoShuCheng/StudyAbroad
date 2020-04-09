//
//  CXSearchViewController.m
//  CXShearchBar_ZSC
//
//  Created by zsc on 2020/4/9.
//  Copyright © 2019年 zsc. All rights reserved.
//

#import "CXSearchViewController.h"
#import "CXSearchModel.h"
#import "CXSearchCollectionViewCell.h"
#import "CXSearchCollectionReusableView.h"
#import "CXSearchLayout.h"
#import "CXDBTool.h"
#import "CZSearchAllViewController.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"

@interface CXSearchViewController ()<UICollectionReusableViewButtonDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *searchDataSource;
@property (strong, nonatomic) CXSearchLayout *searchLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (nonatomic, strong)IBOutlet UIView *searchBgView;
@property (nonatomic, strong)IBOutlet UIImageView *searchIconView;
@property (strong, nonatomic) CZSearchAllViewController *searchVC;

@end

 NSString *const kHistoryKey = @"kHistoryKey";
const CGFloat kMinimumInteritemSpacing = 10;
const CGFloat kFirstitemleftSpace = 15;

@implementation CXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpdata];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(CZSearchAllViewController *)searchVC
{
    if (!_searchVC) {
        _searchVC = [[CZSearchAllViewController alloc] init];
    }
    return _searchVC;
}

- (void)setUpUI {
    [self addChildViewController:self.searchVC];

    self.searchIconView.image = [CZImageProvider imageNamed:@"sou_su_hui"];
    
    self.searchBgView.layer.cornerRadius = 4;
    self.searchBgView.layer.masksToBounds = YES;
    
    self.searchCollectionView.alwaysBounceVertical = YES;
    self.searchCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.searchTextField.delegate = self;
    self.searchCollectionView.dataSource = self;
    self.searchCollectionView.delegate = self;
    
    [self.searchCollectionView setCollectionViewLayout:self.searchLayout animated:YES];
    [self.searchCollectionView registerClass:[CXSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CXSearchCollectionReusableView class])];
    [self.searchCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CXSearchCollectionViewCell class]) bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:NSStringFromClass([CXSearchCollectionViewCell class])];
    
    [self.view addSubview:self.searchVC.view];
    self.searchVC.view.hidden = YES;
    [self.searchVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.searchCollectionView);
    }];
}

- (void)setUpdata {
    
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    [service requestForApiTypeFindHotSearchTypeByCallBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (success && data && [data count] > 0) {
                NSMutableArray *datas = [[NSMutableArray alloc] init];
                [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [datas addObject:obj[@"stName"]];
                }];
                
                [datas enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    CXSearchModel *searchModel = [[CXSearchModel alloc] initWithName:obj searchId:[NSString stringWithFormat:@"%lu",idx + 1]];
                    [self.dataSource addObject:searchModel];
                }];
                
                [self.searchCollectionView reloadData];
            }
            
        });
    }];
    
    //去数据库取数据
    NSArray *dbDatas =  [CXDBTool statusesWithKey:kHistoryKey];
    if (dbDatas.count > 0) {
        [self.searchDataSource setArray:dbDatas];
    }
    
//    NSArray *datas = @[@"化妆棉",@"面膜",@"口红",@"眼霜",@"洗面奶",@"防晒霜",@"补水",@"香水",@"眉笔"];
//    [datas enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CXSearchModel *searchModel = [[CXSearchModel alloc] initWithName:obj searchId:[NSString stringWithFormat:@"%u",idx + 1]];
//        [self.dataSource addObject:searchModel];
//    }];
//    //去数据库取数据
//    NSArray *dbDatas =  [CXDBTool statusesWithKey:kHistoryKey];
//    if (dbDatas.count > 0) {
//        [self.searchDataSource setArray:dbDatas];
//    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataSource.count;
    } else if(section == 1) {
        return self.searchDataSource.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CXSearchCollectionViewCell class]) forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.searchDataSource.count > 0) {
        return 2;
    }
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    
    CXSearchCollectionViewCell * searchCollectionViewCell = (CXSearchCollectionViewCell *)cell;
    CXSearchModel *searchModel;
    if (section == 0) {
         searchModel = self.dataSource[item];
    } else if (section == 1) {
        searchModel = self.searchDataSource[item];
    }
    searchCollectionViewCell.text = searchModel.content;
};

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        CXSearchCollectionReusableView* searchCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([CXSearchCollectionReusableView class]) forIndexPath:indexPath];
        searchCollectionReusableView.delegate = self;
        if(indexPath.section == 0) {
            searchCollectionReusableView.text = @"热门搜索";
            searchCollectionReusableView.hidenDeleteBtn = YES;
        }else if(indexPath.section == 1){
            searchCollectionReusableView.text = @"最近搜索";
            searchCollectionReusableView.hidenDeleteBtn = NO;
        }
        reusableview = searchCollectionReusableView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    if (section == 0) {
        CXSearchModel *searchModel = self.dataSource[item];
        return [CXSearchCollectionViewCell getSizeWithText:searchModel.content];
    } else if (section == 1) {
        CXSearchModel *searchModel = self.searchDataSource[item];
        return [CXSearchCollectionViewCell getSizeWithText:searchModel.content];
    }
    return CGSizeMake(80, 24);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    CXSearchModel *searchModel;
    if (section == 0) {
        searchModel =  self.dataSource[item];
    } else if (section == 1){
         searchModel =  self.searchDataSource[item];
    }
    
    self.searchVC.view.hidden = NO;
    self.searchCollectionView.hidden = !self.searchVC.view.hidden;
    self.searchTextField.text = searchModel.content;
    
    [self.searchVC.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vc respondsToSelector:@selector(setKeywords:)]) {
            [vc performSelector:@selector(setKeywords:) withObject:searchModel.content];
        }
        
        if ([vc respondsToSelector:@selector(reloadData)]) {
            [vc performSelector:@selector(reloadData) withObject:nil];
        }
    }];
}

- (UIAlertController *)showAlertWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        
        self.searchVC.view.hidden = NO;
        self.searchCollectionView.hidden = !self.searchVC.view.hidden;
        
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    __block BOOL isExist = NO;
    [self.searchDataSource enumerateObjectsUsingBlock:^(CXSearchModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([textField.text isEqualToString:obj.content]) {
            isExist = YES;
            *stop = YES;
        }
    }];
    [self.dataSource enumerateObjectsUsingBlock:^(CXSearchModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([textField.text isEqualToString:obj.content]) {
            isExist = YES;
            *stop = YES;
        }
    }];
    
    self.searchVC.view.hidden = textField.text.length == 0;
    self.searchCollectionView.hidden = !self.searchVC.view.hidden;
    
    [self.searchVC.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vc respondsToSelector:@selector(setKeywords:)]) {
            [vc performSelector:@selector(setKeywords:) withObject:textField.text];
        }
        
        if ([vc respondsToSelector:@selector(reloadData)]) {
            [vc performSelector:@selector(reloadData) withObject:nil];
        }
    }];
    
    if (!isExist) {
        [self reloadData:textField.text];
    }

    return isExist;
}

- (void)reloadData:(NSString *)textString {
    CXSearchModel *searchModel = [[CXSearchModel alloc] initWithName:textString searchId:@""];
    [self.searchDataSource addObject:searchModel];
    //存数据
    [CXDBTool saveStatuses:[self.searchDataSource copy] key:kHistoryKey];
    [self.searchCollectionView reloadData];
    self.searchTextField.text = @"";
}

- (IBAction)cancleClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)deleteDatas:(CXSearchCollectionReusableView *)view {
    [self.searchDataSource removeAllObjects];
    [self.searchCollectionView reloadData];
    [CXDBTool saveStatuses:@[] key:kHistoryKey];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)searchDataSource {
    if (!_searchDataSource) {
        _searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}

- (CXSearchLayout *)searchLayout{
    if (!_searchLayout) {
        _searchLayout = [[CXSearchLayout alloc] init];
        _searchLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
        _searchLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
        _searchLayout.minimumLineSpacing = kMinimumInteritemSpacing;
        _searchLayout.listItemSpace = kMinimumInteritemSpacing;
        _searchLayout.sectionInset = UIEdgeInsetsMake(20, kFirstitemleftSpace, 0, kFirstitemleftSpace);
    }
    return _searchLayout;
}

@end
