//
//  ControlView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-5.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//


#import "ControlView.h"
#import "ArticleViewController.h"

#import "DatabaseManager.h"


@interface ControlView ()
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *connectionData;
@property (nonatomic, retain) UIButton *downloadBtn;//下载按钮
@property (nonatomic, retain) UIButton *collectionBtn;
@property (nonatomic, assign) BOOL isCollection;
@end

@implementation ControlView
- (void)dealloc
{
    [_collectionBtn release];
    [_connection release];
    [_article release];
    [_connectionData release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        评论
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:commentBtn];
        [commentBtn setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
//        收藏
        self.collectionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.collectionBtn];
        [self.collectionBtn setImage:[UIImage imageNamed:@"weishoucang.png"] forState:UIControlStateNormal];
//        下载
        self.downloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.downloadBtn];
        [self.downloadBtn setImage:[UIImage imageNamed:@"xiazai.png"] forState:UIControlStateNormal];
//        原文
        UIButton *articleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:articleBtn];
        [articleBtn setImage:[UIImage imageNamed:@"yuanwen.png"] forState:UIControlStateNormal];
        commentBtn.tintColor = [UIColor whiteColor];
        self.collectionBtn.tintColor = [UIColor whiteColor];
        self.downloadBtn.tintColor = [UIColor whiteColor];
        articleBtn.tintColor = [UIColor whiteColor];
        
        commentBtn.frame = CGRectMake(0, 0, 80, frame.size.height);
        self.collectionBtn.frame = CGRectMake(frame.size.width / 4, 0, frame.size.width / 4, frame.size.height);
        self.downloadBtn.frame = CGRectMake(frame.size.width / 4 * 2, 0, frame.size.width / 4, frame.size.height);
        articleBtn.frame = CGRectMake(frame.size.width / 4 * 3, 0, frame.size.width / 4, frame.size.height);
        [commentBtn addTarget:self action:@selector(commentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.collectionBtn addTarget:self action:@selector(collectionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.downloadBtn addTarget:self action:@selector(downloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [articleBtn addTarget:self action:@selector(articleBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}
//评论方法
- (void)commentBtnAction:(UIButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"本功能暂未开放，尽情期待" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}
/**
 *  收藏方法
 */
- (void)collectionBtnAction:(UIButton *)button
{
    
    DatabaseManager *dbManager = [[DatabaseManager alloc] init];
    [dbManager connectionDatabaseName:@"FM.db" tableName:@"articleTB" column1Name:@"musicUrl" column1Type:@"text" column2Name:@"title" column2Type:@"text" column3Name:@"musicImage" column3Type:@"text" column4Name:@"speak" column4Type:@"text"];
    if (self.isCollection) {
        [dbManager useDatabase:@"FM.db" deleteFromTable:@"articleTB" whereColumn1:@"musicUrl" value1:self.article.url andColumn2:@"title" value2:self.article.title];
        self.isCollection = NO;
        [self.collectionBtn setTintColor:[UIColor whiteColor]];
    } else {
        
        [dbManager useDatabase:@"FM.db" insertIntoTableName:@"articleTB" value1:self.article.url value2:self.article.title value3:self.article.cover value4:self.article.speak];
        self.isCollection = YES;
        [self.collectionBtn setTintColor:[UIColor redColor]];
    }
}
//查询数据库是否收藏
- (void)selectIsCollection
{
    DatabaseManager *dbManager = [[DatabaseManager alloc] init];
    NSArray *array =  [dbManager useDatabase:@"FM.db" selectAllFromTable:@"articleTB" whereColumn1:@"musicUrl" value1:self.article.url column2:@"title" value2:self.article.title];
    if (array.count != 0) {
        [self.collectionBtn setTintColor:[UIColor redColor]];
        self.isCollection = YES;
        [self.collectionBtn setTintColor:[UIColor redColor]];
    } else {
        self.isCollection = NO;
        [self.collectionBtn setTintColor:[UIColor whiteColor]];
    }
}
//下载方法
- (void)downloadBtnAction:(UIButton *)button
{
//    M3U8Handler *handel = [[M3U8Handler alloc] init];
//    handel.delegate = self;
//    [handel praseUrl:self.article.url];
//    //开启网络指示器
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];


    
    NSURL    *url = [NSURL URLWithString:self.article.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableData *data = [[NSMutableData alloc] init];
    self.connectionData = data;
    [data release];
    NSURLConnection *newConnection = [[NSURLConnection alloc]
                                      initWithRequest:request
                                      delegate:self
                                      startImmediately:YES];
    self.connection = newConnection;
    [newConnection release];
    if (self.connection != nil){
        NSLog(@"Successfully created the connection");
        [self.downloadBtn setUserInteractionEnabled:NO];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
    } else {
        NSLog(@"Could not create the connection");
    }

    
}
/**
 *  下载方法
 *  @return <#return value description#>
 */
- (void) connection:(NSURLConnection *)connection
   didFailWithError:(NSError *)error{
    NSLog(@"An error happened");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.article.title message:@"下载未成功，请重新点击下载！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.downloadBtn setUserInteractionEnabled:YES];

    NSLog(@"%@", error);
}
- (void) connection:(NSURLConnection *)connection
     didReceiveData:(NSData *)data{
    NSLog(@"Received data");
    [self.connectionData appendData:data];
}
- (void) connectionDidFinishLoading
:(NSURLConnection *)connection{
    /* 下载的数据 */
    
    NSLog(@"下载成功");
    NSString *downPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0
                          ];
    NSLog(@"downPath = %@", downPath);
    
    BOOL cc = [self.connectionData writeToFile:[downPath stringByAppendingString:[NSString stringWithFormat:@"/download/%@.mp3", self.article.title]] atomically:YES];
    if (cc) {
        NSLog(@"保存成功.");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.downloadBtn setUserInteractionEnabled:NO];
        [self.downloadBtn setTintColor:[UIColor grayColor]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.article.title message:@"下载成功！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSLog(@"保存失败.");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.article.title message:@"下载未成功，请重新点击下载！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.downloadBtn setUserInteractionEnabled:YES];
    }
    
    /* do something with the data here */
}
- (void) connection:(NSURLConnection *)connection
 didReceiveResponse:(NSURLResponse *)response{
    [self.connectionData setLength:0];
}


//显示原文方法
- (void)articleBtnAction:(UIButton *)button
{
    if ([_article.word_url isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"本音乐没有原文，请静静欣赏" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        
    UIViewController *viewController = [self viewController];
    ArticleViewController *articleVC = [[ArticleViewController alloc] init];
    articleVC.article = self.article;
    [viewController presentViewController:articleVC animated:YES completion:^{
    }];
    }

}
//获得controller
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }  
    }
    return nil;
}
- (void)setArticle:(FMTitle *)article
{
    if (_article != article) {
        [_article release];
        _article = [article retain];
        [self getDownLoadIsTrue];
        [self selectIsCollection];
    }
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
    
    NSString *musicName = [NSString stringWithFormat:@"%@.mp3", self.article.title];
    for (int i = 0; i < fileList.count; i++) {
        if ([musicName isEqualToString:[fileList objectAtIndex:i]]) {
            [self.downloadBtn setUserInteractionEnabled:NO];
            [self.downloadBtn setTintColor:[UIColor grayColor]];
            return;
        } else {
            [self.downloadBtn setUserInteractionEnabled:YES];
            [self.downloadBtn setTintColor:[UIColor whiteColor]];
        }
        
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
