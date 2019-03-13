//
//  OptionViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "OptionViewController.h"
#import "MyMoviePlayerViewController.h"
#import "DatabaseManager.h"
#import "MusicDetailViewController.h"
#import "StartOrSuspendView.h"
@interface OptionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *resultArray;
@property (nonatomic, retain) UISegmentedControl *segment;
@end

@implementation OptionViewController
-(void)dealloc
{
    [_segment release];
    [_resultArray release];
    [_tableView release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self segmentAction:_segment];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的小屋";
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"我的收藏", @"我的下载"]];
    [self.view addSubview:self.segment];
    self.segment.frame = CGRectMake(10, 64, 300, 40);
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.segment.selectedSegmentIndex = 0;

    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(10, 104, 300, self.view.frame.size.height - 104) style:UITableViewStyleGrouped] autorelease];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
- (void)getDownLoadIsTrue
{
    NSString *downloadPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *downloadDirPath = [NSString stringWithFormat:@"%@/download",downloadPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    查看是否有文件夹 没有就创建
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:downloadDirPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:downloadDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"downloadPath : %@", downloadDirPath);
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:downloadDirPath error:&error];
    NSLog(@"路径==%@,fileList%@", downloadDirPath,fileList);
    if (fileList.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有下载,赶紧到播放页面下载喜欢的FM吧！😊" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    self.resultArray = (NSMutableArray *)fileList;
    
}

- (void)segmentAction:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        NSLog(@"收藏");
        DatabaseManager *dbManager = [[DatabaseManager alloc] init];
      self.resultArray = [dbManager useDatabase:@"FM.db" selectAllFromTable:@"articleTB" whereColumn1:nil value1:nil column2:nil value2:nil];
        if (_resultArray.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有收藏噢！赶紧去收藏吧！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        [_tableView reloadData];
        
    } else if (seg.selectedSegmentIndex == 1) {
        NSLog(@"下载");
        [self getDownLoadIsTrue];
        [_tableView reloadData];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segment.selectedSegmentIndex == 0) {
        
    static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str] autorelease];
    }
    cell.textLabel.text = [[self.resultArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
    } else {
        static NSString *str = @"reuse1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str] autorelease];
        }
        cell.textLabel.text = [self.resultArray objectAtIndex:indexPath.row];
        return cell;

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_segment.selectedSegmentIndex == 0) {
        FMTitle *article = [[FMTitle alloc] init];
        article.title = [[self.resultArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        article.url = [[self.resultArray objectAtIndex:indexPath.row] objectForKey:@"musicUrl"];
        article.cover = [[self.resultArray objectAtIndex:indexPath.row] objectForKey:@"musicImage"];
        article.speak = [[self.resultArray objectAtIndex:indexPath.row] objectForKey:@"speak"];
        StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
        view.article = article;
        //播放器
        MyMoviePlayerViewController *player = [MyMoviePlayerViewController     shareInstance];
        
        MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
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
    } else {
        MyMoviePlayerViewController *player = [MyMoviePlayerViewController     shareInstance];
        StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
        NSString *downloadPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *downloadDirPath = [NSString stringWithFormat:@"%@/download",downloadPath];
        if ([player isStart]) {
            [player.moviePlayer stop];
            [view circlePase];
            NSString *localUrl = [self.resultArray objectAtIndex:indexPath.row];
            NSLog(@"%@", localUrl);
            NSString *musicUrl = [NSString stringWithFormat:@"%@/%@", downloadDirPath, localUrl];
            
            NSLog(@"地址－－－－－%@", musicUrl);
//            player.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
            NSURL *url = [[NSURL alloc] initFileURLWithPath:musicUrl];
            player.moviePlayer.contentURL = url;
            [player.moviePlayer play];
            [view circleTurn];
        } else {
            NSString *localUrl = [self.resultArray objectAtIndex:indexPath.row];
            NSString *musicUrl = [NSString stringWithFormat:@"%@/%@", downloadDirPath, localUrl];
            NSLog(@"地址－－－－－%@", musicUrl);
//            player.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
            NSURL *url = [[NSURL alloc] initFileURLWithPath:musicUrl];
            player.moviePlayer.contentURL = url;
            [player.moviePlayer play];
            //        [view circlePase];
            [view circleTurn];
        }

    }
   
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
