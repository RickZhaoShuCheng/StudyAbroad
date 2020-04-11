//
//  CZOrganizerInfoView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerInfoView.h"
#import "CZOrganizerInfoCell.h"
#import "CZOrganizerInfoHeaderView.h"
@interface CZOrganizerInfoView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UIButton *foldBtn;

@property (nonatomic ,strong) NSArray *titleArr;
@property (nonatomic ,strong) CZOrganizerInfoHeaderView *headerView;
@end
@implementation CZOrganizerInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.titleArr = @[@"执业许可",@"荣誉展示",@"机构环境"];
        [self initWithUI];
    }
    return self;
}
- (void)setModel:(CZOrganizerModel *)model{
    _model = model;
    CGFloat x = self.headerView.contentLab.frame.origin.x;
    model.introduceHeight = [self getStringHeightWithText:model.desc font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth-ScreenScale(30)-x];
    self.headerView.bounds = CGRectMake(0, 0, kScreenWidth, ScreenScale(280) + model.introduceHeight);
    self.headerView.model = model;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZOrganizerInfoCell class]) forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.row];
    cell.type = indexPath.row;
    NSMutableArray *businessImgsArr = [NSMutableArray array];
    if (self.model.businessImgs.length) {
        [businessImgsArr addObjectsFromArray:[self.model.businessImgs componentsSeparatedByString:@","]];
    }
    cell.businessImgs = businessImgsArr;
    NSMutableArray *honorImgsArr = [NSMutableArray array];
    if (self.model.honorImgs.length) {
        [honorImgsArr addObjectsFromArray:[self.model.honorImgs componentsSeparatedByString:@","]];
    }
    cell.honorImgs = honorImgsArr;
    NSMutableArray *envImgsArr = [NSMutableArray array];
    if (self.model.envImgs.length) {
        [envImgsArr addObjectsFromArray:[self.model.honorImgs componentsSeparatedByString:@","]];
    }
    cell.envImgs = envImgsArr;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(260);
}
//点击折叠
- (void)clickFoldBtn{
    if (self.clickFoldBtnBlock) {
        self.clickFoldBtnBlock();
    }
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.backgroundColor = [UIColor whiteColor];
    self.foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foldBtn setImage:[CZImageProvider imageNamed:@"zhediejiantou"] forState:UIControlStateNormal];
    [self.foldBtn addTarget:self action:@selector(clickFoldBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.foldBtn];
    [self.foldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        if (IPHONE_X) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-(kBottomSafeHeight + ScreenScale(20)));
        }else{
            make.bottom.mas_equalTo(self.mas_bottom).offset(-ScreenScale(20));
        }
        make.size.mas_equalTo(ScreenScale(60));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CZOrganizerInfoCell class] forCellReuseIdentifier:NSStringFromClass([CZOrganizerInfoCell class])];
    self.tableView.tableHeaderView = self.headerView;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.foldBtn.mas_top).offset(-ScreenScale(20));
    }];
}

- (CZOrganizerInfoHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CZOrganizerInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(400))];
    }
    return _headerView;
}
- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
@end
