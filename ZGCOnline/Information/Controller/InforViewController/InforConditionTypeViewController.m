//
//  InforConditionTypeViewController.m
//  ZGCOnline
//
//  Created by Lee on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "InforConditionTypeViewController.h"
#import "Network.h"
#import "List.h"
#import "InforWebViewController.h"
#import "InforTableViewCell1.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface InforConditionTypeViewController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) List *list;

@end

@implementation InforConditionTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.page = 1;
        self.listArray = [NSMutableArray array];

        
        
    }
    return self;
}

- (void)getTableViewData
{
    NSString *str = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/doc_index2.php?class_id=%@&subclass_id=427&page=%d&locationid=%@&provinceid=%@&isiphone=1&vs=and370&imei=355546052408831", self.classID, self.page, self.locationID, self.provinceID];
       [Network connectNetGetDataWithUrlString:str complement:^(id result) {
        self.listArray = [result objectForKey:@"list"];
           
        [self.tableView reloadData];
      
    }];



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
    
    //[self.fakaArr insertObject:self.collectArray atIndex:0];
    
    //    [self.fakaArr addObjectsFromArray:self.collectArray];
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
    self.page ++;
    
    // 1.添加假数据
     NSString *str = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/doc_index2.php?class_id=%@&subclass_id=427&page=%d&locationid=%@&provinceid=%@&isiphone=1&vs=and370&imei=355546052408831", self.classID, self.page, self.locationID, self.provinceID];
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
        [self.listArray addObjectsFromArray:[result objectForKey:@"list"]];
    }];
    
    
    //   [self.fakaArr addObject:self.listArray];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = [NSString stringWithFormat:@"%@市%@行情", self.cityName, self.className];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
  

    [self getTableViewData];
    [self setupRefresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.list = [[List alloc] init];
    [self.list setValuesForKeysWithDictionary:[self.listArray objectAtIndex:indexPath.row]];
    
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
    
    cell.Mylabel3.text = [NSString stringWithFormat:@"%@%@", [self.list.comment_num stringValue], @"评论"];
    
    
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.list = [[List alloc] init];
    
    //KVC
    [self.list setValuesForKeysWithDictionary:[self.listArray objectAtIndex:indexPath.row]];
    
    InforWebViewController *webView = [[InforWebViewController alloc] init];
    webView.webID = self.list.listID;
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{

    [_classID release];
    [_locationID release];
    [_provinceID release];
    [_list release];
    [_listArray release];
    [_tableView release];
    [_cityName release];
    [_className release];
    [super dealloc];
    
    
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
