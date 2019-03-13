//
//  ProductDetailsTableViewController.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-10.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ProductDetailsTableViewController.h"
#import "ProductInformationViewController.h"
#import "Network.h"
#import "MyselectfourpageCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface ProductDetailsTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView1;
@property (nonatomic, retain) NSDictionary *myproDic;
@property (nonatomic,retain ) UIImageView *myImage;
@property (nonatomic, retain) NSMutableArray *array1;
@property (nonatomic, retain) NSMutableArray *array2;

@property (nonatomic, assign)NSInteger page;

@end


@implementation ProductDetailsTableViewController






//#pragma mark - 加载
//
//- (void)setupRefresh
//{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
////    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing1)];
//    //#warning 自动刷新(一进入程序就下拉刷新)
//    //    [self.tableView headerBeginRefreshing];
//
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing1)];
//}
//
//#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//
//
//    self.page = 1;
//    [self getData1];
//
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView headerEndRefreshing];
//    });
//}



//- (void)footerRereshing
//{
//
//    // 上拉刷新 page++
//    self.page ++;
//
//    NSString *str2 = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Pro_List&keyword=&subcateId=%@&manuId=&orderBy=1&page=1&&getProInfo=1&getMainParamNum=4&noParam=1&num=10&hideSeries=1&UserIMEI=97dd69def72a2c2c555a749d048a508c53b70992",self.chuan];
//    [Network connectNetGetDataWithUrlString:str2 complement:^(id result) {
////        [self.listArray addObjectsFromArray:[result objectForKey:@"list"]];
//    }];
//
//
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//    });
//}
//



- (void)getData1
{
    
    NSString *str2 = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Pro_List&keyword=&subcateId=%@&manuId=&orderBy=1&page=1&&getProInfo=1&getMainParamNum=4&noParam=1&num=10&hideSeries=1&UserIMEI=97dd69def72a2c2c555a749d048a508c53b70992",self.chuan];
    
    [Network connectNetGetDataWithUrlString:str2 complement:^(id result) {
        
        
        self.myproDic = result;
        
        [self.tableView reloadData];
    }];
    
}





- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
    //    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height - 64) style:   UITableViewStylePlain ];
    //
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    
    [self.view addSubview:_tableView1];
    
    NSLog(@"2352352353253");
    [_tableView1 release];
    
    [self getData1];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [[self.myproDic objectForKey:@"data"] count ];
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%s", __func__);
    static NSString *str = @"reuse";
    
    
    MyselectfourpageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[MyselectfourpageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
    }
    
    
    [cell.myImageView setImageWithURL:[NSURL URLWithString:[[[self.myproDic objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"120x90Pic"]]];
    
    cell.myLabel1.text = [[[self.myproDic objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    cell.myLabel2.text = [[[self.myproDic objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"price"];
    
    cell.myLabel3.text = [[[[[self.myproDic objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"mainParam"] objectAtIndex:0] objectForKey:@"value"];
    cell.myLabel4.text = [[[[[self.myproDic objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"mainParam"] objectAtIndex:1] objectForKey:@"value"];
    cell.myLabel5.text = [[[[[self.myproDic objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"mainParam"] objectAtIndex:2] objectForKey:@"value"];
    
    
    return cell;
    
    
    
    //tableHeaderView
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductInformationViewController *productI = [[ProductInformationViewController alloc] init];
    [self.navigationController pushViewController:productI animated:YES];
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [productI release];
    NSLog(@"%@", indexPath);
}





//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
