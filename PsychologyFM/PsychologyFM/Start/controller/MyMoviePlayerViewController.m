//
//  MyMoviePlayerViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-8-1.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "MyMoviePlayerViewController.h"
#import "PlayerView.h"

#import "StartOrSuspendView.h"
#import "HomeViewController.h"
#import "CircleView.h"
#import "MusicDetailViewController.h"
@interface MyMoviePlayerViewController ()
{
    
}
@property (nonatomic, retain) PlayerView *playerView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) CircleView *circleImageView;
@property (nonatomic, assign) CGFloat currentTime;

@end

@implementation MyMoviePlayerViewController
- (void)dealloc
{
    [_circleImageView release];
    [_imageView release];
    [_article release];
    [_playerView release];
    [_httpServer release];
    [_downloader release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isStart = NO;
        
    }
    return self;
}

+(MyMoviePlayerViewController *)shareInstance
{

    static MyMoviePlayerViewController *player = nil;
    if (!player) {
        player = [[MyMoviePlayerViewController alloc] init];
    }
    return player;
    
}
//单例
- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}
- (oneway void)release
{
    
}
- (id)autorelease
{
    return self;
}

- (void)play
{
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        self.moviePlayer.initialPlaybackTime = _currentTime;
        [self.moviePlayer play];
    } else {
        [self.moviePlayer pause];
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded ;
    [self.moviePlayer pause];
    self.moviePlayer.shouldAutoplay = NO;

    
}
//监控音频时长
- (void)notificationAction:(NSNotification *)notification
{
    NSLog(@"---%@", notification);
            NSLog(@"all time == %f", self.moviePlayer.duration);
    NSLog(@"%f分 %d秒", self.moviePlayer.duration / 60, (int)self.moviePlayer.duration % 60);
    double duration = (double)self.moviePlayer.duration;
    MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
    musicDetailVC.duration = duration;
    NSLog(@"%f", duration);
    
    
}

- (void)setArticle:(FMTitle *)article
{
    if (_article != article) {
        [_article release];
        _article = [article retain];
        self.moviePlayer.contentURL = [NSURL URLWithString:_article.url];
        NSLog(@"all time == %f", self.moviePlayer.duration);
        
        NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
        [notification addObserver:self selector:@selector(notificationAction:) name:MPMovieDurationAvailableNotification object:self.moviePlayer];
    }
}

//
//- (void)openHttpServer
//{
//    self.httpServer = [[HTTPServer alloc] init];
//    [self.httpServer setType:@"_http._tcp."];  // 设置服务类型
//    [self.httpServer setPort:12345]; // 设置服务器端口
//    
//    // 获取本地Documents路径
//    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
//    
//    // 获取本地Documents路径下downloads路径
//    NSString *webPath = [pathPrefix stringByAppendingPathComponent:kPathDownload];
//    NSLog(@"-------------\nSetting document root: %@\n", webPath);
//	
//    // 设置服务器路径
//	[self.httpServer setDocumentRoot:webPath];
//    NSError *error;
//    
//	if(![self.httpServer start:&error])
//	{
//        NSLog(@"-------------\nError starting HTTP Server: %@\n", error);
//	}
//}
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
