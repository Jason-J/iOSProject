//
//  InfoViewController.m
//  Zhongguancun
//
//  Created by jason on 14-7-7.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "InfoViewController.h"
#import "InforSecondViewController.h"
#import "Network.h"
#import "collectionViewCell.h"
#import "List.h"
#import "InforTableViewCell1.h"
#import "inforTableViewCell2.h"
#import "UIImageView+WebCache.h"
#import "InforWebViewController.h"
#import "InforConditionTypeViewController.h"
#import "InforCityViewController.h"
#import "MJRefresh.h"

@interface InfoViewController ()

@property (nonatomic, retain)UITableView *tableView;
//@property (nonatomic, retain)InforSecondViewController *InforSecondVC;

@property (nonatomic, retain)NSMutableArray *array;     // 除collection外的字典数组
@property (nonatomic, retain)NSMutableArray *collectArray;     // 只有首页collectionView上的数组



@property (nonatomic, retain)UICollectionView *collectionView;

@property (nonatomic, retain)NSString *ID;
@property (nonatomic, assign)NSInteger page;     // 刷新页面

@property (nonatomic, retain)List *list;     // 用于KVC赋值
@property (nonatomic, retain)NSMutableDictionary *picsDic;
@property (nonatomic, retain)NSMutableArray *listArray;

@property (nonatomic, retain)collectionViewCell *cell;

@property (nonatomic, retain)NSArray *conditionTypeArray;     //


@property (nonatomic, copy)NSString *cityID;     // condition页面地址参数
@property (nonatomic, retain)NSNumber *provinceID;     // condition页面地址参数
@property (nonatomic, copy)NSString *cityName;

@property (nonatomic, copy)NSString *arrPath;     // 两个数组写入本地的路径
@property (nonatomic, copy)NSString *collectPath;




@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
//        self.InforSecondVC = [InforSecondViewController alloc];
        self.array= [NSMutableArray array];
        self.collectArray = [NSMutableArray array];
        self.page = 1;
        self.picsDic = [NSMutableDictionary dictionary];
        self.listArray = [NSMutableArray array];
        self.conditionTypeArray = [NSArray array];
        self.cityID = @"17245";
        self.provinceID = [NSNumber numberWithInt:6];
        self.cityName = @"大连";
        
        
        }
    return self;
}

#pragma mark - 加载

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];


}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    
    self.page = 1;
    [self getTableViewData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    
    // 上拉刷新 page++
    self.page ++;
    
    NSString *str = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/docList.php?class_id=%@&page=%d&vs=and370&retina=1", self.ID, self.page];
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
        [self.listArray addObjectsFromArray:[result objectForKey:@"list"]];
    }];
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

     
#pragma mark 结束刷新状态


- (void)getCollectionData
{
    NSString *str = @"http://lib.wap.zol.com.cn/ipj/classList.php?vs=and370";
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
      
        for (NSDictionary *dic in result) {
            if (!([[dic objectForKey:@"id"] isEqualToString:@"4"] || [[dic objectForKey:@"id"] isEqualToString:@"0"] || [[dic objectForKey:@"id"] isEqualToString:@"1"] ||[[dic objectForKey:@"id"] isEqualToString:@"2"] || [[dic objectForKey:@"id"] isEqualToString:@"74"] || [[dic objectForKey:@"id"] isEqualToString:@"7"])) {
                [self.array addObject:dic];
            }
        }
       
       
        for (NSDictionary *dic in result) {
            if ([[dic objectForKey:@"id"] isEqualToString:@"0"] || [[dic objectForKey:@"id"] isEqualToString:@"1"] ||[[dic objectForKey:@"id"] isEqualToString:@"2"] || [[dic objectForKey:@"id"] isEqualToString:@"74"] || [[dic objectForKey:@"id"] isEqualToString:@"7"]) {
                [self.collectArray addObject:dic];
            }
        }
        [self writeToLoad];
      
        [self.collectionView reloadData];
        
        NSLog(@"qweqweqwe");
        
     }];
    
 
}
// 写入本地
- (void)writeToLoad
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *collectPath = [path stringByAppendingPathComponent:@"collectarray.plist"];
    NSString *arrayPath = [path stringByAppendingPathComponent:@"array.plist"];
    
    NSArray *collectarr = [NSArray arrayWithArray:self.collectArray];
    NSArray *arr = [NSArray arrayWithArray:self.array];
    
    [NSKeyedArchiver archiveRootObject:collectarr toFile:collectPath];
    [NSKeyedArchiver archiveRootObject:arr toFile:arrayPath];

}

// 本地读取
- (NSArray *)setCollectLoad
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *arrPath = [path stringByAppendingPathComponent:@"collectarray.plist"];


     NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:arrPath];
    

    return array;
    
    NSLog(@"adasdasd");
}
- (NSArray *)setArrLoad
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *arrPath = [path stringByAppendingPathComponent:@"array.plist"];
    
    
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:arrPath];
    
    
    NSLog(@"load %@", self.array);
    
    return array;


}

-(void) getTableViewData
{
    NSString *str = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/docList.php?class_id=%@&page=%d&vs=and370&retina=1", self.ID, self.page];
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
        if (nil != [result objectForKey:@"pics"]) {
            self.picsDic = [[result objectForKey:@"pics"] objectAtIndex:0];
            
//            [self.picsDic addEntriesFromDictionary:[[result objectForKey:@"pics"] objectAtIndex:0]];
        }
        self.listArray = [result objectForKey:@"list"];
        [self.tableView reloadData];

        // 如果picDic不为0 创建HeaderView
        if (!([self.picsDic allKeys].count == 0)) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 115, 320, 150)];
            self.tableView.tableHeaderView = view;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [view addSubview:button];
            button.frame = view.bounds;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 310, 150)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 135, 200, 15)];
            label.text = [self.picsDic objectForKeyedSubscript:@"stitle"];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            [imageView addSubview:label];
            NSURL *url = [NSURL URLWithString:[self.picsDic objectForKey:@"imgsrc"]];
            [imageView setImageWithURL:url];
            [view addSubview:imageView];
//            self.picsDic = 0;
           
        } else {
            self.tableView.tableHeaderView = nil;
        }
    }];
}

// 行情页面数据处理
- (void)getConditionTypeData
{
    NSString *str = @"http://lib.wap.zol.com.cn/ipj/doc_subcate.php?vs=iph361&UserIMEI=ed77f70ccf6b8d4c103c11cb79f54cc8cba32f32";
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
        self.conditionTypeArray = [result objectForKey:@"2"];
        [self writeLoad];
    }];

}
- (void)writeLoad
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *apath = [path stringByAppendingPathComponent:@"condition.plist"];
    NSArray *array = [NSArray arrayWithArray:self.conditionTypeArray];
    [NSKeyedArchiver archiveRootObject:array toFile:apath];
}

- (NSArray *)setLaod
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *apath = [path stringByAppendingPathComponent:@"condition.plist"];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:apath];
    return array;
}

// 行情页面自定义section

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.ID isEqualToString:@"5"]) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        headerView.backgroundColor = [UIColor grayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        label.text = @"当前城市";
        label.font = [UIFont systemFontOfSize:20];
        [headerView addSubview:label];
        [label release];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(250, 0, 50, 40);
        [button setTitle:@"大连" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ButtonCity:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
                
        return headerView;
    }
    return nil;

}

// section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.ID isEqualToString:@"5"]) {
        return 40;
    }

    return 0;
}

- (void)ButtonCity:(UIButton *)button
{
    InforCityViewController *inforCityVC = [[InforCityViewController alloc] init];
    [self.navigationController pushViewController:inforCityVC animated:YES];
    
    // block 传 城市信息
    [inforCityVC ValueCity:^(NSString *cityName, NSString *cityID, NSNumber *provinceID) {
        [button setTitle:cityName forState:UIControlStateNormal];
        self.cityName = cityName;
        self.cityID = cityID;
        self.provinceID = provinceID;
    
    }];
    
   
    [inforCityVC release];
}

//  跳转页面 tabBar 消失
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;

}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)buttonAction:(UIButton *)button
{
    NSLog(@"点击头条跳转");
    InforWebViewController *webView = [[InforWebViewController alloc] init];
    webView.webID = [self.picsDic objectForKey:@"id"];

    [self.navigationController pushViewController:webView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if ([self setCollectLoad] == nil) {
       [self getCollectionData];
    } else {
        self.collectArray = [NSMutableArray arrayWithArray:[self setCollectLoad]];
        self.array = [NSMutableArray arrayWithArray:[self setArrLoad]];
       
    
    }
     
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115, 320, 400) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];


    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(55, 40);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 280, 50) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    [self.collectionView registerClass:[collectionViewCell class] forCellWithReuseIdentifier:@"collectionReuse"];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    //[button setTitle:@"添加" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(275, 69, 40, 40);
    button.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.8];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    // 判断本地是否有文件
 
    [self getTableViewData];
    
    if ([self setLaod] != nil) {
        self.conditionTypeArray = [NSMutableArray arrayWithArray:[self setLaod]];
    } else {
       
        [self getConditionTypeData];
    }

    [self setupRefresh];
    
    [flowLayout release];
   

}

// 根据CollectionArray的count判断collection的cell数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectArray count];

}

// cell点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!([self.ID isEqualToString:@"5"])) {
        
        self.list = [[List alloc] init];
        //KVC
        [self.list setValuesForKeysWithDictionary:[self.listArray objectAtIndex:indexPath.row]];
        
        InforWebViewController *webView = [[InforWebViewController alloc] init];
        webView.webID = self.list.listID;
        [self.navigationController pushViewController:webView animated:YES];
        
    } else {
        // 点击行情类型跳转
        InforConditionTypeViewController *inforCondeitionVC = [[InforConditionTypeViewController alloc] init];
        
        inforCondeitionVC.locationID = self.cityID;
        inforCondeitionVC.provinceID = self.provinceID;
        inforCondeitionVC.classID = [[self.conditionTypeArray objectAtIndex:indexPath.row] objectForKey:@"id"];
        inforCondeitionVC.cityName = self.cityName;
        inforCondeitionVC.className = [[self.conditionTypeArray objectAtIndex:indexPath.row] objectForKey:@"name"];
     
        [self.navigationController pushViewController:inforCondeitionVC animated:YES];
        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // NSString *str  = [NSString stringWithFormat:@"collectionReuse%d",indexPath.row];
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionReuse" forIndexPath:indexPath];
    self.cell.contentView.backgroundColor = [UIColor clearColor];
    
    self.cell.label.text = [[self.collectArray objectAtIndex:indexPath.item] objectForKey:@"name"];
    
    self.cell.label.textAlignment = NSTextAlignmentCenter;
    self.cell.layer.borderWidth = 1.5;
    self.cell.layer.borderColor = [[UIColor whiteColor]CGColor];
    
  
    return self.cell;

}

// 点击collectionViewcell  给 TableView 传ID
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.picsDic removeAllObjects];

    self.ID = [[self.collectArray objectAtIndex:indexPath.item] objectForKey:@"id"];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 360, 44)];
    titleLable.textAlignment = 1;
    titleLable.text = [NSString stringWithFormat:@"%@",[[self.collectArray objectAtIndex:indexPath.item] objectForKey:@"name"]];
    self.navigationItem.titleView = titleLable;
    [titleLable release];
    
    [self getTableViewData];
    NSLog(@"self.ID%@", self.ID);
     self.tableView.contentOffset = CGPointZero;
    
}

// 点击添加按钮方法
- (void)buttonClicked:(UIButton *)button
{
    InforSecondViewController *InforSecondVC = [[InforSecondViewController alloc] init];
    [self.navigationController pushViewController:InforSecondVC animated:YES];
    InforSecondVC.didCollectionArray = self.collectArray;
    InforSecondVC.moreCollectionArray = self.array;
    //NSLog(@"did:%@", InforSecondVC.didCollectionArray);
    
    // block 传值
    [InforSecondVC valueArray:^(NSMutableArray *array) {
        self.collectArray = array;
        [self.collectionView reloadData];
    }];
    
    [InforSecondVC release];
    
}


// 自定义tableViewcell高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    List *list = [[List alloc] init];
    [list setValuesForKeysWithDictionary:[self.listArray objectAtIndex:indexPath.row]];
    if ([list.type isEqualToString:@"6" ]) {
        [list release];
        return 140;
    }
    // 行情页面cell高
    if ([self.ID isEqualToString:@"5"]){
    return 50;
    }
    
    return 90;
}


// tableView方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listArray != nil) {
        
        return [self.listArray count];
    }
    // 行情 cell 数
    if ([self.ID isEqualToString:@"5"]) {
        
        return [self.conditionTypeArray count];
    }
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.list = [[List alloc] init];
    [self.list setValuesForKeysWithDictionary:[self.listArray objectAtIndex:indexPath.row]];
    
    if ([self.list.type isEqualToString:@"6"]) {
        NSString *str2 = @"reuse2";
        inforTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:str2];
        if (nil == cell) {
            cell = [[[inforTableViewCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str2] autorelease];
            
        }
        
        NSURL *url1 = [NSURL URLWithString:[self.list.pics objectAtIndex:0]];
        [cell.MyImageView1 setImageWithURL:url1];
        
        NSURL *url2 = [NSURL URLWithString:[self.list.pics objectAtIndex:1]];
        [cell.MyIamgeView2 setImageWithURL:url2];
        
        NSURL *url3 = [NSURL URLWithString:[self.list.pics objectAtIndex:2]];
        [cell.MyImageView3 setImageWithURL:url3];
        
        cell.MyLabel1.text = self.list.stitle;
        
        NSRange range = {5, 5};
        NSString *str = self.list.sdate;
        NSString *strr = [str substringWithRange:range];
        cell.MyLabel2.text = strr;
        
        cell.MyLabel3.text = [NSString stringWithFormat:@"%@图", [self.list.pic_num stringValue]];
        
        cell.MyLabel4.text = [NSString stringWithFormat:@"%@评论", self.list.comment_num];
        return cell;
    }
    // 行情页面
    if ([self.ID isEqualToString:@"5"]) {
        NSString *str = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
            
        }
        cell.textLabel.text = [[self.conditionTypeArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
    else {
        NSString *str1 = @"reuse1";
        InforTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:str1];
        if (nil == cell) {
            cell = [[[InforTableViewCell1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str1] autorelease];
        }
        
        NSURL *url = [NSURL URLWithString:self.list.imgsrc];
        [cell.MyimageView setImageWithURL:url];
        
        cell.Mylabel1.text = self.list.stitle;
        
        // 日期截取
        NSRange range = {5, 5};
        NSString *str = self.list.sdate;
        NSString *str2 = [str substringWithRange:range];
        cell.Mylabel2.text = str2;
        
        if (self.list.comment_num != 0) {
            
            cell.Mylabel3.text = [NSString stringWithFormat:@"%@%@", [self.list.comment_num stringValue], @"评论"];
        }
        
        
        
        return cell;

    }
    
    
}


- (void)dealloc
{
    [_tableView release];
    [_list release];
    [_collectArray release];
    [_array release];
    [_cityName release];
    [_cityID release];
    [_collectionView release];
    [_conditionTypeArray release];
    [_cell release];
    [_picsDic release];
    [_ID release];
    [_listArray release];
    [super dealloc];
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
