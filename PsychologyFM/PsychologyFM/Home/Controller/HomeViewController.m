//
//  HomeViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseCell.h"
#import "HomeCell.h"
#import "Network.h"
#import "FMTitle.h"
#import "SceneModel.h"
#import "HeaderViewForTableView.h"
#import "MJRefresh.h"
#import "TitleTabBarView.h"
#import "StartViewController.h"
#import "MyMoviePlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "StartOrSuspendView.h"
#import "MusicDetailViewController.h"
@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, M3U8HandlerDelegate, VideoDownloadDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *onePageArray;
@property (nonatomic, retain) NSMutableArray *tableViewArray;
//headerView
@property (nonatomic, retain) HeaderViewForTableView *headerView;
@property (nonatomic, retain) TitleTabBarView *titleTBV;
@property (nonatomic, assign) int page;

@property (nonatomic, retain) NSMutableArray *allTagArray;
-(void)getData;
@end

@implementation HomeViewController
-(void)dealloc
{
    [_allTagArray release];
    [_onePageArray release];
    [_headerView release];
    [_tableView release];
    [_tableViewArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableViewArray = [NSMutableArray array];
        self.allTagArray = [NSMutableArray array];
        _page = 0;
    }
    return self;
}
+(HomeViewController *)shareInstance
{
    static HomeViewController *homeVC = nil;
    if (!homeVC) {
        homeVC  = [[HomeViewController alloc] init];
        
    }
    return [[homeVC retain] autorelease];
}
/**
 *  请求数据
 */
- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"http://bapi.xinli001.com/fm/broadcasts.json/?rows=10&key=9f3f57a7483a05ec42ecd912549276f0&offset=%d&speaker_id=0", self.page];
    [Network connectNetGetDataWithUrlString:url complement:^(id result) {
        self.onePageArray = [result objectForKey:@"data"];
        NSLog(@"%ld", self.onePageArray.count);
        for (int i = 0; i < self.onePageArray.count; i++) {
            FMTitle *article = [[FMTitle alloc] init];
            [article setValuesForKeysWithDictionary:self.onePageArray[i]];
            [self.tableViewArray addObject:article];
        }
        self.headerView.title = self.tableViewArray[0];
        NSLog(@"%ld", self.tableViewArray.count);
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];

}
- (void)getAllTagData
{
    NSString *sceneUrl = @"http://bapi.xinli001.com/fm/hot_tags.json/?flag=2&key=f6738336b525ad18efcad3ec8340d7ee&rows=9&offset=0";
    NSString *mindUrl = @"http://bapi.xinli001.com/fm/hot_tags.json/?flag=3&key=f6738336b525ad18efcad3ec8340d7ee&rows=9&offset=0";
    NSMutableArray *tempArray = [NSMutableArray array];
    [Network connectNetGetDataWithUrlString:sceneUrl complement:^(id result) {
        for (int i = 0; i < [[result objectForKey:@"data"] count]; i++) {
            SceneModel *scene = [[SceneModel alloc] init];
            [scene setValuesForKeysWithDictionary:[[result objectForKey:@"data"] objectAtIndex:i]];
            [tempArray addObject:scene];
        }
        [Network connectNetGetDataWithUrlString:mindUrl complement:^(id result) {
            for (int i = 0; i < [[result objectForKey:@"data"] count]; i++) {
                SceneModel *scene = [[SceneModel alloc] init];
                [scene setValuesForKeysWithDictionary:[[result objectForKey:@"data"] objectAtIndex:i]];
                [tempArray addObject:scene];
            }
            self.allTagArray = tempArray;
        }];

    }];
    NSLog(@"allTagCount == %d", self.allTagArray.count);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.headerView = [[HeaderViewForTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    self.tableView.tableHeaderView = self.headerView;
    self.titleTBV = [TitleTabBarView shareInstanceWithFrame:CGRectMake(0, 0, 320, 46)];
    self.navigationItem.titleView = self.titleTBV;

    [self.view addSubview:self.tableView];
    [self.tableView release];
    [self setupRefresh];
    [self getAllTagData];
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuse";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    cell.cellData = [self.tableViewArray objectAtIndex:indexPath.row + 1];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArray.count - 1;
}
//点击cell触发方法
//点击让文章题目显示到头上
#pragma mark ----------在线流媒体播放----------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMTitle *article = [self.tableViewArray objectAtIndex:indexPath.row + 1];
    self.titleTBV.viewData = (BaseModel *)article;
    StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
    view.article = article;
    //播放器
    MyMoviePlayerViewController *player = [MyMoviePlayerViewController     shareInstance];
    
    MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
    musicDetailVC.currentPlay = indexPath.row;
    musicDetailVC.FMListArray = self.tableViewArray;
    musicDetailVC.article = article;
    if ([player isStart]) {
        [player.moviePlayer stop];
        [view circlePase];
        player.article = article ;
        [player.moviePlayer play];
        [view circleTurn];
    } else {
        player.article = article;
        [player.moviePlayer play];
//        [view circlePase];
        [view circleTurn];
    }
    [self presentViewController:musicDetailVC animated:YES completion:^{
    
    }];
    

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}
- (void)setAllTagArray:(NSMutableArray *)allTagArray
{
    if (_allTagArray != allTagArray) {
        [_allTagArray release];
        _allTagArray = [allTagArray retain];
        NSLog(@"allTagCount == %d", _allTagArray.count);
        [self writeToLocal];
    }
}
/**
 *  归档
 */
- (void)writeToLocal
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tagPath = [docPath stringByAppendingPathComponent:@"tag.txt"];
    NSLog(@"归档路径 %@", tagPath);
    [NSKeyedArchiver archiveRootObject:_allTagArray toFile:tagPath];
    
    NSMutableArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithFile:tagPath];
    NSLog(@"读出的数组长度是%d", tempArray.count);
    
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    [self.tableViewArray removeAllObjects];
    self.page = 0;
    [self getData];
    
}
- (void)footerRereshing
{
    self.page += 10;
    [self getData];
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
