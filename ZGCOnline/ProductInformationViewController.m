//
//  ProductInformationViewController.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ProductInformationViewController.h"
#import "Network.h"
#import "MyselectfiveTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ProductInformationViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView2;
@end

@implementation ProductInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView2 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView2.dataSource = self;
    _tableView2.delegate = self;
    [self.view addSubview:_tableView2];
    [_tableView2 release];
    
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    //    button.backgroundColor = [UIColor clearColor];
    //    button.frame = CGRectMake(120, 125, 100, 30);
    //    [button setTitle:@"参数" forState:UIControlStateNormal];
    ////    button.layer.cornerRadius = 50;
    //    button.titleLabel.font = [UIFont systemFontOfSize:18];
    //    [button addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
    ////    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    ////    self.navigationItem.rightBarButtonItem = buttonItem;
    
}

- (void)buttonCliked:(UIButton *)button
{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return 10;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //如果同一个tableview里面需要使用多个不同布局的cell,在这个方法重需要创建多个不同的 重用标识，用户区分不同的cell
    static NSString *str = @"down";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
