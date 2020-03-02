//
//  CZOrganizerHomeViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerHomeViewController.h"
#import "CZHomeBannerView.h"
#import "CZCarefullyChooseViewController.h"
#import "CZDiaryViewController.h"
#import "CZSchoolStarViewController.h"
#import "CZAdvisorViewController.h"
#import "CZOrganizerListViewController.h"
#import "CZSelectCityViewController.h"
#import "CZServiceBannerView.h"
#import "CZCourseView.h"
#import "CZCourseModel.h"
#import "CZHomeFilterView.h"
#import "MenuAction.h"
#import "DropMenuBar.h"
#import "CZSearchBar.h"
#import "CZSchoolStarView.h"
#import "CZHotActivityView.h"
#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"
#import "CZHomeModel.h"
#import "UIImageView+WebCache.h"
#import "CZSchoolStarModel.h"
#import "CZActivityModel.h"
#import "CZBoardView.h"
#import "QSClient.h"
#import "CZCountryUtil.h"

static NSInteger sectionCount = 6;
static CGFloat filterHeight = 95;

typedef enum : NSUInteger {
    CZTableSectionTypeService,
    CZTableSectionCourse,
    CZTableSectionSchoolStar,
    CZTableSectionHotActivity,
    CZTableSectionBoard,
    CZTableSectionFilter,
} CZTableSectionType;

@interface CZOrganizerHomeViewController ()<DropMenuBarDelegate,CZHomeFilterViewDelegate>
@property (nonatomic , strong) CZHomeBannerView *bannerView;//轮播图
@property (nonatomic , strong) UIImageView *bannerBottomView;//轮播图bottom
@property (nonatomic , strong) CZServiceBannerView *serviceBannerView;//服务选择图
@property (nonatomic , strong) CZCourseView *courseView;//课程选择图
@property (nonatomic , strong) UIView *courseContainerView;//课程选择图(容器)
@property (nonatomic , strong) CZHomeFilterView *homeFilterView;
@property (nonatomic , strong) UIView *homeFilterContainerView;
@property (nonatomic , assign) BOOL canScroll;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@property (nonatomic, strong) NSArray<MenuAction *> *actions;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIButton *shopButton;
@property (nonatomic, strong) CZSearchBar *searchBar;
@property (nonatomic, strong) CZSchoolStarView *startView;
@property (nonatomic, strong) CZHotActivityView *activityView;
@property (nonatomic, strong) CZBoardView *boardView;
@property (nonatomic , strong) UIView *boardContainerView;
//data
@property (nonatomic, strong) NSMutableDictionary *dataDicts;
@property (nonatomic, strong) NSMutableArray *schoolStars;
@property (nonatomic, strong) NSMutableArray *hotActivities;

@end

@implementation CZOrganizerHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForHomeData];
    [self requestForSchoolStars];
    [self requestForHotActivities];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.canScroll = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self createDefaultFilterMenu];
    [self createNavigationBar];
}

//导航布局
-(void)createNavigationBar
{
    self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.locationButton setImage:[CZImageProvider imageNamed:@"zhu_ye_di_zhi_ding_wei"] forState:UIControlStateNormal];
    self.locationButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.locationButton setTitle:NSLocalizedString(@"南京", nil) forState:UIControlStateNormal];
    [self.locationButton addTarget:self action:@selector(actionForSelectCity) forControlEvents:UIControlEventTouchUpInside];
    [self.locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [self.locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.locationButton.frame = CGRectMake(0, 0, 60, 40);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.locationButton];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    self.shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shopButton setImage:[CZImageProvider imageNamed:@"zhu_ye_dao_hang_gou_wu_che_an_niu"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.shopButton];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.searchBar = [[CZSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    self.searchBar.userInteractionEnabled = NO;
    self.navigationItem.titleView = self.searchBar;
}

- (CZHomeBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[CZHomeBannerView alloc] init];
        _bannerView.customView = self.bannerBottomView;
    }
    return _bannerView;
}

-(void)actionForSelectCity
{
    CZSelectCityViewController *controller = [[CZSelectCityViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(UIImageView *)bannerBottomView
{
    if (!_bannerBottomView) {
        CGFloat width = self.view.bounds.size.width;
        _bannerBottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width/375.0*41.0)];
    }
    return _bannerBottomView;
}

-(CZServiceBannerView *)serviceBannerView
{
    if (!_serviceBannerView) {
        _serviceBannerView = [[CZServiceBannerView alloc] initLayoutByHeight:0];
    }
    return _serviceBannerView;
}

-(CZCourseView *)courseView
{
    if (!_courseView) {
        _courseView = [[CZCourseView alloc] initWithCourses:@[] container:self.courseContainerView];
    }
    return _courseView;
}

-(CZBoardView *)boardView
{
    if (!_boardView) {
        _boardView = [[CZBoardView alloc] initWithBoards:@[] container:self.boardContainerView];
    }
    return _boardView;
}

-(UIView *)courseContainerView
{
    if (!_courseContainerView) {
        _courseContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/2.0)];
    }
    return _courseContainerView;
}

-(UIView *)boardContainerView
{
    if (!_boardContainerView) {
        _boardContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width-50)];
    }
    return _boardContainerView;
}

-(UIView *)homeFilterContainerView
{
    if (!_homeFilterContainerView) {
        _homeFilterContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, filterHeight)];
    }
    return _homeFilterContainerView;
}

-(CZHotActivityView *)activityView
{
    if (!_activityView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 15;
        layout.itemSize = CGSizeMake(160, 187);
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        _activityView = [[CZHotActivityView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) collectionViewLayout:layout];
    }
    return _activityView;
}

-(CZSchoolStarView *)startView
{
    if (!_startView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 15;
        layout.itemSize = CGSizeMake(129, 150);
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 0)];

        _startView = [[CZSchoolStarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) collectionViewLayout:layout];
    }
    return _startView;
}

//override
-(UIView *)tableHeaderView
{
    return self.bannerView;
}

// 子类化实现
- (NSArray<UIViewController<CZScrollContentControllerDeleagte> *> *)contentScrollers
{
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    CZCarefullyChooseViewController *controller1 = [[CZCarefullyChooseViewController alloc]init];
    [arry addObject:controller1];
    CZDiaryViewController *controller2 = [[CZDiaryViewController alloc]init];
    [arry addObject:controller2];
    CZSchoolStarViewController *controller3 = [[CZSchoolStarViewController alloc]init];
    [arry addObject:controller3];
    CZAdvisorViewController *controller4 = [[CZAdvisorViewController alloc]init];
    [arry addObject:controller4];
    CZOrganizerListViewController *controller5 = [[CZOrganizerListViewController alloc]init];
    [arry addObject:controller5];
    return arry;
}

- (UIView *)tableViewForHeaderInSection:(NSInteger)section
{
    if (section == CZTableSectionFilter) {
        if (!self.homeFilterView) {
            self.homeFilterView = [[CZHomeFilterView alloc] initWithSuperView:self.homeFilterContainerView];
            self.homeFilterView.menuScreeningView.actions = self.actions;
            self.homeFilterView.delegate = self;
        }
        return self.homeFilterContainerView;
    }
    
    if (section >= CZTableSectionSchoolStar && section <= CZTableSectionBoard) {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        containerView.backgroundColor = CZColorCreater(245, 245, 249, 1.0);
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 10,containerView.bounds.size.width , CGRectGetHeight(containerView.frame)-10)];
        [containerView addSubview:header];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        nameLabel.textColor = [UIColor blackColor];
        [header addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_greaterThanOrEqualTo(0);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        
        switch (section) {
            case CZTableSectionSchoolStar:
                [self addMoreButton:header];
                nameLabel.text = NSLocalizedString(@"留学达人", nil);
                break;
            case CZTableSectionHotActivity:
                [self addMoreButton:header];
                nameLabel.text = NSLocalizedString(@"热门活动", nil);
                break;
            case CZTableSectionBoard:
                nameLabel.text = NSLocalizedString(@"留学榜单", nil);
                break;
            default:
                break;
        }
        
        return containerView;
    }
    
    return nil;
}

-(CGFloat)tableViewCellHeightForAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 150;
        case 1:
            return [UIScreen mainScreen].bounds.size.width/2.0;
        case 2:
            return 187;
        case 3:
            return 187;
        case 4:
            return self.view.bounds.size.width-50;
        default:
            return 0;
    }
}

-(NSInteger)tableViewSectionCountForSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
            return 1;
        default:
            return 0;
    }
}

-(NSInteger)setSectionCout
{
    return sectionCount;
}

-(UITableViewCell *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellider = @"serviceCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [cell.contentView addSubview:self.serviceBannerView];
            
            return cell;
        }
        
        case 1:
        {
            static NSString *cellider = @"courseCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [cell.contentView addSubview:self.courseView];
            
            return cell;
            
        }
            
        case 2:
        {
            static NSString *cellider = @"starCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [cell.contentView addSubview:self.startView];
            return cell;
            
        }
        case 3:
        {
            static NSString *cellider = @"activityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [cell.contentView addSubview:self.activityView];
            return cell;
            
        }
        case 4:
        {
            static NSString *cellider = @"boardCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [cell.contentView addSubview:self.boardContainerView];
            return cell;
            
        }
        default:
            return nil;
    }
}

-(void)didScrolling:(BOOL)canScroll
{
    self.menuScreeningView.hidden = canScroll;
    
    if (self.canScroll != canScroll) {
        if (!canScroll) {
            self.menuScreeningView.actions = self.actions;
        }
        else
        {
            self.homeFilterView.menuScreeningView.actions = self.actions;
        }
    }
    self.canScroll = canScroll;
}

-(void)addMoreButton:(UIView *)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
    }];
    UIImageView *moreImageView = [[UIImageView alloc] init];
    moreImageView.image = [CZImageProvider imageNamed:@"zhu_ye_you_jian_tou"];
    [button addSubview:moreImageView];
    [moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    UILabel *moreLabel = [[UILabel alloc] init];
    moreLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    moreLabel.textColor = CZColorCreater(126, 126, 146, 1);
    moreLabel.text = NSLocalizedString(@"More", nil);
    [button addSubview:moreLabel];
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.right.mas_equalTo(moreImageView.mas_left).offset(-5);
        make.centerY.mas_equalTo(0);
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)createDefaultFilterMenu
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 15; i++) {
        BOOL select = i == 0;
        ItemModel *model = [ItemModel modelWithText:[NSString stringWithFormat:@" == %d", i] currentID:[NSString stringWithFormat:@"%d", i] isSelect:select];
        [array addObject:model];
    }
    
    MenuAction *smartSort = [MenuAction actionWithTitle:NSLocalizedString(@"智能排序", nil) style:MenuActionTypeList];
    smartSort.ListDataSource = array;
    smartSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"1111 === %@", selecModel.displayText);
    };
    
    NSMutableArray *countrys = [[NSMutableArray alloc] init];
    NSMutableArray *countryDatas = [CZCountryUtil sharedInstance].datas;
    for (int i = 0; i < countryDatas.count; i++) {
        CZSCountryModel *country = countryDatas[i];
        BOOL select = i == 0;
        ItemModel *model = [ItemModel modelWithText:country.country.area_name currentID:country.country.ID isSelect:select];
        [countrys addObject:model];
    }
    
    MenuAction *countrySort = [MenuAction actionWithTitle:NSLocalizedString(@"国家", nil) style:MenuActionTypeList];
    countrySort.ListDataSource = countrys;
    countrySort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"1111 === %@", selecModel.displayText);
    };
    
    MenuAction *profassionnalSort = [MenuAction actionWithTitle:NSLocalizedString(@"专业", nil) style:MenuActionTypeList];
    profassionnalSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"1111 === %@", selecModel.displayText);
    };
    
    MenuAction *citySort = [MenuAction actionWithTitle:NSLocalizedString(@"城市", nil) style:MenuActionTypeList];
    citySort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"1111 === %@", selecModel.displayText);
    };
    
    MenuAction *filterSort = [MenuAction actionWithTitle:NSLocalizedString(@"筛选", nil) style:MenuActionTypeList];
    filterSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"1111 === %@", selecModel.displayText);
    };
    
    self.menuScreeningView = [[DropMenuBar alloc] initWithAction:@[smartSort, countrySort,profassionnalSort,citySort,filterSort]];
    self.menuScreeningView.delegate = self;
    self.menuScreeningView.frame = CGRectMake(0, 50, self.view.frame.size.width, 45);
    self.menuScreeningView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuScreeningView];
    self.menuScreeningView.hidden = YES;
    self.actions = self.menuScreeningView.actions;
}

- (void)dropMenuViewWillAppear:(DropMenuBar *)view selectAction:(MenuAction *)action
{
    if (self.canScroll) {
        [self scrollToBottom];
    }
}
- (void)dropMenuViewWillDisAppear:(DropMenuBar *)view selectAction:(MenuAction *)action
{
    
}

#pragma - Network

-(void)requestForHomeData
{
    QSOrganizerHomeService *service = [QSCommonService service:QSServiceTypeOrganizerHome];
    [service requestForApiPlaceholderFindPlaceholderMapBySpType:@(1) callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            for (NSDictionary *dict in data) {
                NSDictionary *nDict = [QSCommonService removeNullFromDictionary:dict];
                NSNumber *zomeType = nDict[@"zoneType"];
                NSArray *datas = [self.dataDicts objectForKey:zomeType];
                NSMutableArray *updateDatas = [NSMutableArray new];
                if (!datas) datas = @[];
                [updateDatas addObjectsFromArray:datas];
                [updateDatas addObject:nDict];
                [self.dataDicts setObject:updateDatas forKey:zomeType];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadDatas];
        });
    }];
}

-(NSMutableDictionary *)dataDicts
{
    if (!_dataDicts) {
        _dataDicts = [[NSMutableDictionary alloc] init];
    }
    return _dataDicts;
}

-(void)reloadDatas
{
    NSMutableArray *items1 = self.dataDicts[@(1)];
    NSMutableArray *pics = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in items1) {
        CZHomeModel *model = [CZHomeModel modelWithDict:dict];
        [pics addObject:PIC_URL(model.spImg)];
    }
    self.bannerView.picsURLs = pics;
    
    
    NSMutableArray *items2 = self.dataDicts[@(2)];
    CZHomeModel *model = [CZHomeModel modelWithDict:[items2 firstObject]];
    [self.bannerBottomView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.spImg)] placeholderImage:nil];
    
    NSMutableArray *items4 = self.dataDicts[@(4)];
    NSMutableArray *courses = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in items4) {
        CZHomeModel *model = [CZHomeModel modelWithDict:dict];
        CZCourseModel *course = [CZCourseModel new];
        course.link = model.url;
        course.cover = PIC_URL(model.spImg);
        [courses addObject:course];
    }
    [self.courseView updateLayoutByCourses:courses];
    
    
    NSMutableArray *items3 = self.dataDicts[@(3)];
    NSMutableArray *services = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in items3) {
        CZHomeModel *model = [CZHomeModel modelWithDict:dict];
        [services addObject:model];
    }
    [self.serviceBannerView reloadByDatas:services];
    
    NSMutableArray *items5 = self.dataDicts[@(5)];
    NSMutableArray *boards = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in items5) {
        CZHomeModel *model = [CZHomeModel modelWithDict:dict];
        [boards addObject:model];
    }
    [self.boardView updateLayoutByBoards:boards];
    
    [self.homeFilterView setRelateScrollView:self.scrollContentView.collectionView];
}

-(NSMutableArray *)schoolStars
{
    if (!_schoolStars) {
        _schoolStars = [[NSMutableArray alloc] init];
    }
    return _schoolStars;
}

-(void)requestForSchoolStars
{
    QSOrganizerHomeService *service = [QSCommonService service:QSServiceTypeOrganizerHome];
    [service requestForApiSportUserGetHomePageSportUser:[QSClient userId] callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            for (NSDictionary *dict in data) {
                NSDictionary *nDict = [QSCommonService removeNullFromDictionary:dict];
                CZSchoolStarModel *model = [CZSchoolStarModel modelWithDict:nDict];
                [self.schoolStars addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
               self.startView.dataArr = self.schoolStars;
               [self.startView reloadData];
            });
        }

    }];
}

-(NSMutableArray *)hotActivities
{
    if (!_hotActivities) {
        _hotActivities = [[NSMutableArray alloc] init];
    }
    return _hotActivities;
}

-(void)requestForHotActivities
{
    QSOrganizerHomeService *service = [QSCommonService service:QSServiceTypeOrganizerHome];
    [service requestForapiProductActivitySelectHotProductActivityByUserId:[QSClient userId] pageNum:@(1) pageSize:@(5) callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            for (NSDictionary *dict in data) {
                NSDictionary *nDict = [QSCommonService removeNullFromDictionary:dict];
                CZActivityModel *model = [CZActivityModel modelWithDict:nDict];
                [self.hotActivities addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
               self.activityView.dataArr = self.hotActivities;
               [self.activityView reloadData];
            });
        }
    }];
}

#pragma - mark CZHomeFilterViewDelegate

-(void)filterView:(CZHomeFilterView *)filterView itemSelectedAtIndex:(NSInteger)index
{
    [self.scrollContentView.collectionView setContentOffset:CGPointMake(index*self.view.bounds.size.width, 0) animated:YES];
}

@end
