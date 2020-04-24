

//
//  CZCommentsListTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsListTableView.h"
#import "CZCommentsCell.h"
@interface CZCommentsListTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign) BOOL isOpen;
@end
@implementation CZCommentsListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.commentsArr = [NSMutableArray array];
        self.isOpen = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZCommentsCell class] forCellReuseIdentifier:NSStringFromClass([CZCommentsCell class])];
        self.tableHeaderView = self.headerView;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setTagListTags:(NSMutableArray *)tagsArr{
    //重新获取数据，置为未打开
    if (self.isOpen) {
        self.isOpen = NO;
        self.headerView.arrowBtn.transform = CGAffineTransformMakeRotation(0*M_PI/180);
    }
    if (tagsArr.count > 0) {
        if (self.headerView.tagList.selectedTags.count <= 0) {
            [self.headerView.tagList.selectedTags addObject:tagsArr[0]];
        }
        self.headerView.tagList.tags = tagsArr;
        if (self.headerView.tagList.contentHeight >= ScreenScale(140)) {
            self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(150), kScreenWidth-ScreenScale(60), ScreenScale(140));
            [self.headerView.arrowBtn setHidden:NO];
        }else{
            self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(150), kScreenWidth-ScreenScale(60), self.headerView.tagList.contentHeight);
            [self.headerView.arrowBtn setHidden:YES];
        }
        if (self.headerView.tagList.contentHeight >= ScreenScale(140)) {
            if (self.isOpen) {
                self.headerView.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(150) + self.headerView.tagList.contentHeight + ScreenScale(60));
            }else{
                self.headerView.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(150) + ScreenScale(140) + ScreenScale(60));
            }
        }else{
            self.headerView.frame = CGRectMake(0, 0, kScreenWidth,ScreenScale(150) + self.headerView.tagList.contentHeight + ScreenScale(40));
        }
        [self reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    CZCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.commentsArr[indexPath.row];
    [cell setClickLikeAction:^(UIButton * _Nonnull likeBtn) {
        if (weakSelf.commentsPraiseBlock) {
            weakSelf.commentsPraiseBlock(indexPath.row,likeBtn);
        }
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 图片高度没算，最多支持6张图片，有机会再优化
    CZCommentModel *model = self.commentsArr[indexPath.row];
    NSMutableArray *imgsArr = [NSMutableArray array];
    if (model.imgs.length) {
        [imgsArr addObjectsFromArray:[model.imgs componentsSeparatedByString:@","]];
    }
    
    if ([imgsArr count] == 0) {
        //无图片
        return ScreenScale(280) + model.commentHeight;
    }else if ([imgsArr count] <= 3) {
        //1-3张
        return ScreenScale(500) + model.commentHeight;
    }else{
        //4-6张
        return ScreenScale(700) + model.commentHeight;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedBlock) {
        self.selectedBlock(self.commentsArr[indexPath.row]);
    }
}
//点击小箭头折叠页面
- (void)openFilter:(UIButton *)button{
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        //逆时针 旋转180度
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2]; //动画时长
        button.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
        CGAffineTransform transform = button.transform;
        //第二个值表示横向放大的倍数，第三个值表示纵向缩小的程度
        transform = CGAffineTransformScale(transform, 1,1);
        button.transform = transform;
        [UIView commitAnimations];
    }else{
        //顺时针 旋转180度
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2]; //动画时长
        button.transform = CGAffineTransformMakeRotation(0*M_PI/180);
        CGAffineTransform transform = button.transform;
        transform = CGAffineTransformScale(transform, 1,1);
        button.transform = transform;
        [UIView commitAnimations];
    }
    if (self.isOpen) {
        self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(150), kScreenWidth-ScreenScale(60), self.headerView.tagList.contentHeight);
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(150) + self.headerView.tagList.contentHeight + ScreenScale(60));
    }else{
        self.headerView.tagList.frame = CGRectMake(ScreenScale(30),ScreenScale(150), kScreenWidth-ScreenScale(60), ScreenScale(140));
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(150) + ScreenScale(140) + ScreenScale(60));
    }
    [self reloadData];
}
- (CZCommentsHeaderView *)headerView{
    if (!_headerView) {
        WEAKSELF
        _headerView = [[CZCommentsHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(150))];
        [_headerView.arrowBtn addTarget:self action:@selector(openFilter:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.tagList didSelectItem:^(NSInteger index) {
            if (weakSelf.selectCommentIndex) {
                weakSelf.selectCommentIndex(index);
            }
        }];
    }
    return _headerView;
}
@end
