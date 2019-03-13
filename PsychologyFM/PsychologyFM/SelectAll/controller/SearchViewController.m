//
//  SearchViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-8-7.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "SearchViewController.h"
#import "HomeCell.h"
#import "Network.h"
#import "FMTitle.h"
#import "MJRefresh.h"
#import "TitleTabBarView.h"
#import "StartOrSuspendView.h"
#import "MyMoviePlayerViewController.h"
#import "MusicDetailViewController.h"
@interface SearchViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchDisplay;
@property (nonatomic, retain) NSMutableArray *searchResultArray;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@property (nonatomic, assign) int page;
@end

@implementation SearchViewController
- (void)dealloc
{
    [_activity release];
    [_searchDisplay release];
    [_searchResultArray release];
    [_searchBar release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.page = 0;
        self.searchResultArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入心情听FM"
    ;
    self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplay.delegate = self;
    tableView.tableHeaderView = self.searchBar;
    //    self.navigationItem.titleView = self.searchBar;
    [self.searchBar setBarStyle:UIBarStyleDefault];
    

    
    self.searchDisplay.searchResultsTableView.dataSource =  self;
    self.searchDisplay.searchResultsTableView.delegate = self;
    [self.searchDisplay.searchResultsTableView registerClass:[HomeCell class] forCellReuseIdentifier:@"reuse"];
}
- (void)refresh
{
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.searchDisplay.searchResultsTableView addSubview:self.activity];
    self.activity.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    self.activity.backgroundColor = [UIColor blackColor];
    [self.activity startAnimating];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchResultArray removeAllObjects];
    [self refresh];
    [self getDataOfTableViewWithSearchBar:searchBar];
    
    [self setupRefresh];

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    NSLog(@"searchBar.text = %@", searchBar.text);
//    [self.searchResultArray removeAllObjects];
//    [self refresh];
//    [self getDataOfTableViewWithSearchBar:searchBar];
//    [self setupRefresh];
//}
- (void)getDataOfTableViewWithSearchBar:(UISearchBar *)searchBar
{
    NSString *url = [NSString stringWithFormat:@"http://bapi.xinli001.com/fm/broadcasts.json/?rows=10&key=9f3f57a7483a05ec42ecd912549276f0&offset=%d&speaker_id=0&q=%@", self.page,searchBar.text];
    
    [Network connectNetGetDataWithUrlString:url complement:^(id result) {
        for (int i = 0; i < [[result objectForKey:@"data"] count]; i ++) {
            FMTitle *article = [[FMTitle alloc] init];
            [article setValuesForKeysWithDictionary:[[result objectForKey:@"data"] objectAtIndex:i]];
            [self.searchResultArray addObject:article];
            [article release];
            [self.searchDisplay.searchResultsTableView reloadData];
        }
        NSLog(@"search count = %d", self.searchResultArray.count);
        [self.activity stopAnimating];
        [self.searchDisplay.searchResultsTableView headerEndRefreshing];
    }];
}
//查找
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    self.searchBar.showsCancelButton = YES;
    return YES;
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchDisplay.searchResultsTableView deselectRowAtIndexPath:indexPath animated:YES];
    FMTitle *article = [self.searchResultArray objectAtIndex:indexPath.row];
    TitleTabBarView *titleTBV = [TitleTabBarView shareInstanceWithFrame:CGRectMake(0, 0, 320, 46)];
    titleTBV.viewData = (BaseModel *)article;
    self.navigationItem.titleView = titleTBV;
    StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
    view.article = article;
    //播放器
    MyMoviePlayerViewController *player = [MyMoviePlayerViewController     shareInstance];
    
    MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
    musicDetailVC.article = article;
    if ([player isStart]) {
        [player.moviePlayer stop];
        player.article = article ;
        [player.moviePlayer play];
        [view circleTurn];
    } else {
        player.article = article;
        [player.moviePlayer play];
        [view circleTurn];
    }
    [self presentViewController:musicDetailVC animated:YES completion:^{
        
    }];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuse";
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[BaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str] autorelease];
    }
    cell.cellData = [self.searchResultArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultArray.count
    ;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.searchDisplay.searchResultsTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.searchDisplay.searchResultsTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    // 1.添加假数据
//    [self.tableViewArray removeAllObjects];
//    self.page = 0;
//    [self getDataOfTableViewWithSearchBar:self.searchBar];
//    
//}
- (void)footerRereshing
{
    self.page += 10;
    [self getDataOfTableViewWithSearchBar:self.searchBar];
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
