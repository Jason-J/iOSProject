//
//  SelectPriceViewController.m
//  Zhongguancun
//
//  Created by jason on 14-7-7.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "SelectPriceViewController.h"
#import "MySelectCell.h"
#import "CustomizationListViewController.h"
#import "Network.h"
#import "ProductDetailsTableViewController.h"
#import "ParticularListViewController.h"

@interface SelectPriceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain)UICollectionView *collectionView1;


@end

@implementation SelectPriceViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(notificationAction:) name:@"movedata" object:nil];
        
        self.array = [[NSMutableArray alloc] init];
        
    }
    return self;
}

//通知中心的触发方法 参数
- (void)notificationAction:(NSNotification *)notification
{
    
    
    // 收到通知中心的通知之后，要实现的内容
    //清空数据
    [self.array removeAllObjects];
    //为可变数组指定初始容量 -addObject:向可变数组的末尾添加一个元素
    [self.array addObjectsFromArray:[notification.userInfo objectForKey:@"name"]];
    
    //    [self.array addObject:[notification.userInfo objectForKey:@"name"]] ;
    
    NSLog(@"++++++++++++++++++++++%@",self.array);
    NSLog(@"userInfo+++++++++: %@",notification.userInfo);
    [self.collectionView reloadData];
    
}

- (void)dealloc
{
    //通知中心的使用
    //所有注册为观察者的对象 都必须在销毁的时候取消掉自己的观察者身份
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    
    //提前注册一个cell类 给collectionView
    [self.collectionView registerClass:[MySelectCell class] forCellWithReuseIdentifier:@"yu"];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(250, 25, 100, 30);
    [button setTitle:@"添加定制" forState:UIControlStateNormal];
    button.layer.cornerRadius = 50;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    
    
    
    
}

- (void)buttonCliked:(UIButton *)button
{
    //跳到第二页
    CustomizationListViewController *cust = [[ CustomizationListViewController  alloc] init];
    [self.navigationController pushViewController:cust animated:YES];
    [cust release];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  [self.array count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MySelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yu" forIndexPath:indexPath];
    //    cell.label.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"yuchenlong"];
    cell.label.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    NSLog(@"_______++_____++++++++%@",cell.label.text);
    
    return  cell;
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductDetailsTableViewController *productD = [[ProductDetailsTableViewController alloc] init];
    //       取Id
    productD.chuan = [[self.array objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    [self.navigationController pushViewController:productD animated:YES];
    
    [productD release];
    NSLog(@"%@", indexPath);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [self.collectionView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
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
