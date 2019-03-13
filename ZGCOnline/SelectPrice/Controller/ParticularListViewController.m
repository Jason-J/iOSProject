//
//  ParticularListViewController.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ParticularListViewController.h"
#import "CustomizationListViewController.h"
#import "SelectPriceViewController.h"


@interface ParticularListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation ParticularListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.notifarray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:_tableView];
    [_tableView release];
    
    //开启tableview的编辑状态
    [_tableView setEditing:YES animated:YES];
    
    //开启viewcontroller的编辑状态
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(250, 25, 50, 30);
    [button setTitle:@"定 制" forState:UIControlStateNormal];
    button.layer.cornerRadius = 50;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    
}
- (void)buttonAction:(UIButton *)button
{
    
    
    
    //向通知中心发送一个通知
    //获得通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = [NSDictionary  dictionaryWithObject:self.notifarray forKey:@"name"];
    [center postNotificationName:@"movedata" object:@"canshu" userInfo:dic];
    //回到第一页
    [self. navigationController popToRootViewControllerAnimated:YES];
    
    
}



//viewcontroller的点击编辑按钮的触发方法
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    [super setEditing:editing animated:animated];
    NSLog(@"%d",editing);
    
    //开启tableview的编辑状态
    [_tableView setEditing:editing  animated:animated];
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"tableView == %d",indexPath.row);
    //NSLog(@"________+++__-%@", self.pagearr );
    
    
    [self.notifarray addObject:self.pagearr[indexPath.row]];
    
    
    //    NSLog(@"________+++__-%@", [[self.pagearr objectAtIndex:indexPath.row] objectForKey:@"name"]);
    //    NSLog(@"_________+++__-%@", [[self.pagearr objectAtIndex:indexPath.row] objectForKey:@"id"]);
    
    //NSLog(@"self.array1:%@", self.notifarray);
    
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除|插入 就是多选
    return  UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.pagearr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    cell.textLabel.text = [[self.pagearr objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
    
    
    
    //    NSArray *arr =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //    NSLog(@"------------***/---%@",arr);
    //
    //    //获得Lib路径
    //    NSString *libPath = [arr lastObject];
    //    NSString *documentPath = [libPath stringByAppendingString:@"/24.tex"];//直接拼接
    //    NSLog(@"%@", documentPath);
    //
    //    // 写入
    //
    //    NSString *arrPath = [libPath stringByAppendingString:@"arr.plist"];
    //    [self.notifarray writeToFile:arrPath atomically:YES];
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
