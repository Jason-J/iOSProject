//
//  InforCityViewController.m
//  ZGCOnline
//
//  Created by Lee on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "InforCityViewController.h"
#import "Network.h"

#import "City.h"

@interface InforCityViewController ()

@property (nonatomic, retain)UITableView *tableView;

@property (nonatomic, retain)UITableView *tableViewSeach;
@property (nonatomic, retain)UISearchBar *searchBar;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, retain) NSMutableArray *strArr;

@property (nonatomic, retain)NSArray *indexArray;
@property (nonatomic, retain)NSArray *titleHeadArray;
@property (nonatomic, retain)City *city;

@end

@implementation InforCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provinceArray = [NSArray array];
        self.cityArray = [NSMutableArray array];
        self.strArr = [NSMutableArray array];
        self.title = @"选择城市";
        
        
        [self setIndexArray:[NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"J", @"K", @"L", @"M", @"N", @"P", @"Q", @"R", @"S", @"T", @"W", @"X", @"Y", @"Z", nil]];
        [self setTitleHeadArray:[NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"J", @"K", @"L", @"M", @"N", @"P", @"Q", @"R", @"S", @"T", @"W", @"X", @"Y", @"Z", nil]];
        
        
        
    }
    return self;
}

- (void)getProvinceData
{
    NSString *str = @"http://lib.wap.zol.com.cn/ipj/abc_city.php?&UserIMEI=ed77f70ccf6b8d4c103c11cb79f54cc8cba32f32";
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
        self.provinceArray = [result objectForKey:@"data"];
        
            [self.tableView reloadData];
        // 得到所有城市的数组
        for (NSDictionary *dic in self.provinceArray) {
            for (NSDictionary *dic1 in [dic objectForKey:@"z_city"]) {
                [self.cityArray addObject:[dic1 objectForKey:@"z_city_name"]];
            }
        }
        NSLog(@"city : %@", self.cityArray);
        
    }];

    
}


//设置索引与section关联
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //获取目录对应的indexPath的值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    //让tableView滚动到indexPath位置
    [[self tableView] scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    return index;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self indexArray];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.bounds.size.height + 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableViewSeach = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height + 64) style:UITableViewStylePlain];
//    self.tableViewSeach.delegate = self;
//    self.tableViewSeach.dataSource = self;

    [self.view addSubview:self.tableViewSeach];
    [self.view addSubview:self.tableView];
    //[self.view bringSubviewToFront:self.tableView];
    
    [self.tableView release];
    
    //设置searchBar
    self.SearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    self.searchBar.Placeholder = @"请输入城市......";     //设置提示信息
    self.searchBar.Delegate = self;
    

    
    
    
    [self.view addSubview:self.searchBar];
    
    [self.searchBar release];

    
    
    
    [self getProvinceData];
}

//searchBar点击search回收键盘方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    
}


//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    self.str = searchText;
//    NSLog(@"%@", self.str);
//    for (int i = 0; i < [self.cityArray count]; i ++) {
//        if ([self.str isEqualToString: [self.cityArray objectAtIndex:i]]) {
//            [self.strArr addObject:self.str];
//            
//            //[self.view bringSubviewToFront:self.tableViewSeach];
//            [self.tableView reloadData];
//        }
//        
//    }
//
//}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"end%@", searchBar.text);
    
    self.str = searchBar.text;

}


// section数（ 数量）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.strArr != nil) {
//        return 0;
//    } else {
    return [self.provinceArray count];
//   }
}

// section名字（省 名字）
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.provinceArray objectAtIndex:section]objectForKey:@"z_pinyin"];

}

// 每个section的cell数 （省 内的 城市 数）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.strArr != nil) {
//        return 1;
//    } else {
    return  [[[self.provinceArray objectAtIndex:section] objectForKey:@"z_city"] count];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // searchBar 判定

//    self.city = [[City alloc] init];
//    [self.city setValuesForKeysWithDictionary:[[[self.provinceArray objectAtIndex:indexPath.section] objectForKey:@"z_city"] objectAtIndex:indexPath.row]];
//    NSLog(@"self.city%@", self.city);
    
        NSString *str = @"reuse";
        UITableViewCell *cell = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:str];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
        }
    
//    if (self.strArr != nil) {
//        cell.textLabel.text = [self.strArr objectAtIndex:0];
//        return cell;
//    } else {
    cell.textLabel.text = [[[[self.provinceArray objectAtIndex:indexPath.section] objectForKey:@"z_city"] objectAtIndex:indexPath.row] objectForKey:@"z_city_name"];
        return cell;
//    }
   
    


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    /// ？？？？？？？？？？？？？？？？？？？？？？？？？？？

    
            
                self.cityName = [[[[self.provinceArray objectAtIndex:indexPath.section] objectForKey:@"z_city"] objectAtIndex:indexPath.row] objectForKey:@"z_city_name"];
                NSLog(@"cityname:%@", self.cityName);
                self.cityID = [[[[self.provinceArray objectAtIndex:indexPath.section] objectForKey:@"z_city"] objectAtIndex:indexPath.row] objectForKey:@"z_location_id"];
                self.provinceID = [[[[self.provinceArray objectAtIndex:indexPath.section] objectForKey:@"z_city"] objectAtIndex:indexPath.row]objectForKey:@"z_province_id"];


//    self.cityName = self.city.z_city_name;
//    self.cityID = self.city.z_location_id;
//    self.provinceID = (NSNumber *)self.city.z_province_id;
    
    
    self.block(self.cityName, self.cityID, self.provinceID);

}

- (void)ValueCity:(CityBlock)block
{
    self.block = block;
}


- (void)dealloc
{
    Block_release(_block);
    [_cityID release];
    [_cityName release];
    [_provinceArray release];
    [_provinceID release];
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
