//
//  XSHeaderViewVC.m
//  TopScaleBackViewOC
//
//  Created by 刘佳斌 on 2019/2/14.
//  Copyright © 2019 xiaosi. All rights reserved.
//

#import "XSHeaderViewVC.h"
#import "XSContentInsetVC.h"

static CGFloat const headerHeight = 240;

@interface XSHeaderViewVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *headerBackView; //头像背景

@end

/*
 自定义一个背景视图作为tableView的头视图，在视图滚动的代理方法里面，得到tableView的偏移量，如果偏移量小于0，让背景视图的高度等于原高度加上偏移量的绝对值，通过现在的高度和初始高度，可以计算出背景视图的缩放比例，根据缩放比例把宽度等比例缩放，最后重新设置背景视图的frame就可以了。
 
 */

@implementation XSHeaderViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self createTableViewHeader];
    }
    return _tableView;
}

- (UIView *)createTableViewHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), headerHeight)];
    _headerBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), headerHeight)];
    _headerBackView.image = [UIImage imageNamed:@"banner1.jpg"];
    [headerView addSubview:_headerBackView];
    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width   = CGRectGetWidth(self.view.frame);
    CGFloat offsetY = scrollView.contentOffset.y; // 获取偏移量
    if (offsetY<0) {
        CGFloat totalHeight = headerHeight+ABS(offsetY);//获取放大后的高度
        CGFloat f = totalHeight / headerHeight; // 获取放大的高度 与 原高度的 比例
        self.headerBackView.frame = CGRectMake(-(width*f-width)/2, offsetY, width*f, totalHeight);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = @"123";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XSContentInsetVC *vc = [[XSContentInsetVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
