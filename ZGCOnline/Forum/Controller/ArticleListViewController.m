//
//  ArticleListViewController.m
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleListView.h"

#import "ArticleViewController.h"
#import "Network.h"

#import "SearchBar/SearchBarViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface ArticleListViewController ()

@property (nonatomic, retain) ArticleListView *articleListView;
@property (nonatomic, retain) SearchBarViewController *searchBarVC;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, retain) FMDatabase *database;
@property (nonatomic, retain) UIBarButtonItem *collectBarBtn;

@end

@implementation ArticleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.db"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userId = @"null";
    // Do any additional setup after loading the view.
    self.searchBarVC = [[SearchBarViewController alloc] init];
    self.articleListView = [[ArticleListView alloc]initWithFrame:self.view.bounds viewController:self];
    
    [self.view addSubview:self.articleListView];

    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.urlStr = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/iphone_list3.1.1.php?bbsid=%@&bid=%@&page=1&q=2&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.bbsid, self.bid];
    [Network connectNetGetDataWithUrlString:self.urlStr complement:^(id result) {

        self.articleListView.aPageArticleList = [result objectForKey:@"list"];
        
    }];
    
    [self.articleListView valueOfPage:^(NSInteger page, NSString *requestType) {
        NSString *nextPageUrl = nil;
        self.articleListView.requestType = requestType;
        if ([requestType isEqualToString:@"refresh"]) {
            
            nextPageUrl = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/iphone_list3.1.1.php?bbsid=%@&bid=%@&page=%@&q=2&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.bbsid, self.bid, @"1"];
            
        } else {
            nextPageUrl = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/iphone_list3.1.1.php?bbsid=%@&bid=%@&page=%@&q=2&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.bbsid, self.bid, [NSString stringWithFormat:@"%d", page ++]];
        }
            
        [Network connectNetGetDataWithUrlString:nextPageUrl complement:^(id result) {
            self.articleListView.aPageArticleList = [result objectForKey:@"list"];
            
        }];
        
    }];
    
    
    [self.articleListView valueOfBookidAndBoardid:^(NSString *bookid, NSString *boardid) {

        

        NSString *urlStr = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/content_ios3.1.1.php?bbsid=%@&bid=%@&bookid=%@&vs=3.2&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.bbsid,boardid, bookid];
        ArticleViewController *articleVC = [[ArticleViewController alloc] init];
        articleVC.urlStr = urlStr;
        NSLog(@"!!!!!!!!!!!!!%@", urlStr);
        NSLog(@"%@", self.bbsid);
        [self.navigationController pushViewController:articleVC animated:YES];
        [articleVC release];
        
    }];
    
//    搜索请求
    [self.articleListView valueOfSearchText:^(NSString *search_text) {

//        self.searchBarVC.search_text = search_text;
//        self.searchBarVC.bbsid = self.bbsid;
//        self.searchBarVC.bid = self.bid;
//        [self.navigationController
//         pushViewController:self.searchBarVC animated:YES];
        
        NSString *url = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/list.php?bbsid=%@&bid=%@&page=1&keyword=%@&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.bbsid, self.bid, search_text];
        [Network connectNetGetDataWithUrlString:url complement:^(id result) {
            NSLog(@"%@", result);
            self.articleListView.searchResurlArray = [result objectForKey:@"list"];
        }];
    }];
    [self.articleListView release];
    
#pragma mark - 收藏按钮定义
    //    收藏按钮
    self.collectBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"weishoucang-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(collectBarBtnAction:)];
    self.collectBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.collectBarBtn;

    self.database = [FMDatabase databaseWithPath:self.dbPath];
    if (![self.database open]) {
        return;
    }
    FMResultSet *resultSet = [self.database executeQuery:@"select * from forumTB where forumUrl = ? and userid = ?", self.urlStr, self.userId];
//  FMResultSet  *resultSet = [self.database executeQuery:@"select * from forumTB"];
    NSLog(@"%@", self.urlStr);
    NSLog(@"%@", self.userId);
    NSLog(@"%@", resultSet);
    while ([resultSet next]) {
        NSLog(@"需要的方法");
        NSString *forumUrl = [resultSet stringForColumn:@"forumUrl"];
        NSString *userId = [resultSet stringForColumn:@"userid"];
        
        if ([forumUrl isEqualToString: self.urlStr] && [userId isEqualToString: self.userId]) {
            self.isCollect = YES;
            [self.collectBarBtn setImage:[UIImage imageNamed:@"yishoucang-icon.png"]];
//
        } else {
            self.isCollect = NO;
            [self.collectBarBtn setImage:[UIImage imageNamed:@"weishoucang-icon.png"]];
        }
    }
    [self.database close];

}

/**
 *  收藏方法
 */
-(void)collectBarBtnAction:(UIBarButtonItem *)barBtn
{
    NSLog(@"收藏");
//    获取文件路径
    NSLog(@"dbpath == %@", self.dbPath);
//    获取数据库并且打开

    if (![self.database open]) {
        NSLog(@"Open datbase failed");
        return  ;
    }
    [self.database open];
//    创建表
    [self.database executeUpdate:@"create table forumTB (forumUrl text userid text, forumName text);"];
    if (self.isCollect) {
        BOOL delete = [self.database executeUpdate:@"delete from forumTB where forumUrl = ? and userid = ?", self.urlStr, self.userId];
        NSLog(@"取消收藏...");
        if (delete) {
            NSLog(@"取消收藏。");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
            self.isCollect = NO;
            [self.collectBarBtn setImage:[UIImage imageNamed:@"weishoucang-icon.png"]];
        }
    } else {
        BOOL insert = [self.database executeUpdate:@"insert into  forumTB values (?, ?, ?)", self.urlStr, self.userId, self.title];
        if (insert) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            self.isCollect = YES;
            [self.collectBarBtn setImage:[UIImage imageNamed:@"yishoucang-icon.png"]];
        }
        
        
    }
    [self.database close];
    
}
-(void)dealloc
{
    [_articleList release];
    [_articleListView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setArticleList:(NSArray *)articleList
{
    if (_articleList != articleList) {
        [_articleList release];
        _articleList = [articleList retain];
    }
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
