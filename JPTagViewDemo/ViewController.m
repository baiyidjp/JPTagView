//
//  ViewController.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerZero.h"
#import "ViewControllerFirst.h"
#import "ViewControllerSecond.h"
#import "ViewControllerThird.h"
#import "ViewControllerFourth.h"
#import "ViewControllerFifth.h"
#import "ViewControllerSix.h"
#import "ViewControllerSeven.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/** dataArray */
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *controller;
    
    switch (indexPath.row) {
        case 0:
        {
            controller = [[ViewControllerZero alloc] init];
            
        }
            break;
        case 1:
        {
            controller = [[ViewControllerFirst alloc] init];
        }
            break;
        case 2:
        {
            controller = [[ViewControllerSecond alloc] init];
        }
            break;
        case 3:
        {
            controller = [[ViewControllerThird alloc] init];
        }
            break;
        case 4:
        {
            controller = [[ViewControllerFourth alloc] init];
        }
            break;
        case 5:
        {
            controller = [[ViewControllerFifth alloc] init];
        }
            break;
        case 6:
        {
            controller = [[ViewControllerSix alloc] init];
        }
            break;
        case 7:
        {
            controller = [[ViewControllerSeven alloc] init];
        }
            break;

    }
    
    controller.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = @[@"0-默认",@"1-不展示组头",@"2-默认展示删除",@"3-圆角加边框",@"4-网络图片背景",@"5-长按展示删除和动画",@"6-展示自定义富文本Tag&代理",@"7-横向"];
    }
    return _dataArray;
}
@end
