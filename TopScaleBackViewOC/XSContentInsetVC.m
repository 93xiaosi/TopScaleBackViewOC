//
//  XSContentInsetVC.m
//  TopScaleBackViewOC
//
//  Created by 刘佳斌 on 2019/2/14.
//  Copyright © 2019 xiaosi. All rights reserved.
//

#import "XSContentInsetVC.h"
static CGFloat const headerHeight = 240;

@interface XSContentInsetVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *headerBackView; //头像背景

@end

/*
 将自定义背景视图放在UITableView上，给tableView设定contentInset属性，将自定义背景视图显示出来，当tableView滚动时，重置背景视图的frame
 */

@implementation XSContentInsetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headerBackView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (UIImageView *)headerBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -headerHeight, CGRectGetWidth(self.view.frame), headerHeight)];
        _headerBackView.contentMode = UIViewContentModeScaleAspectFill;
        _headerBackView.image = [UIImage imageNamed:@"banner2.jpg"];
    }
    return _headerBackView;
}

//MARK: -- 重点
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前偏移位置  tableview 设置了 contentinset 加statusbar20像素
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -headerHeight) {
        CGRect rect = self.headerBackView.frame;
        rect.origin.y = offsetY;
        rect.size.height = -offsetY;
        self.headerBackView.frame = rect;
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
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
