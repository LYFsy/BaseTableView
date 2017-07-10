//
//  ViewController.m
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "BaseRefreshTableView.h"
#import "CustomCell.h"
@interface ViewController ()<BaseTableViewDelegate>
@property(nonatomic,strong)BaseRefreshTableView *tableView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableviewConfigure];
}

- (void)tableviewConfigure {
    self.tableView = [[BaseRefreshTableView alloc]initWithFrame:self.view.bounds];
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"cellId"];
    [self tableViewCellDrawRectMethod];
    [self tableViewDidSelectedCellMethod];
    self.tableView.iDelegate = self;
    [self.view addSubview:_tableView];
    [self.tableView autoRefresh];
}

#pragma mark tableViewCell的渲染方法，(根据需要做相应的逻辑渲染)
- (void)tableViewCellDrawRectMethod {
    __weak ViewController *weakSelf = self;

    self.tableView.callbackCell = ^UITableViewCell *(UITableViewCell *cell, NSIndexPath *indexPath) {
        CustomCell * customeCell = [[CustomCell alloc]init];
        customeCell.label.text = [NSString stringWithFormat:@"%@",weakSelf.tableView.dataArray[indexPath.row]];
        return customeCell;
    };
}

#pragma mark tableViewCell的点击方法
- (void)tableViewDidSelectedCellMethod {
    __weak ViewController *weakSelf = self;

    self.tableView.callbackDidSelectedCell = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        [weakSelf.navigationController pushViewController:[[FirstViewController alloc]initWithTitle:[NSString stringWithFormat:@"%@",weakSelf.tableView.dataArray[indexPath.row]]] animated:YES];
    };
}

#pragma mark BaseTableViewDelegate---- Request Data Method
#pragma mark 刷新
- (void)requestDataByDelegate {
    
    self.tableView.dataArray = @[@1,@2,@3,@4,@5,@6].mutableCopy;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    self.tableView.isLoading = NO;
}
#pragma mark 加载
- (void)requestMoreDataByDelegate {
    for (int ii = 0; ii < 10; ii ++) {
        [self.tableView.dataArray addObject:@(ii)];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    self.tableView.isLoading = NO;
}

- (IBAction)clearData:(UIBarButtonItem *)sender {
    [self.tableView.dataArray removeAllObjects];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
