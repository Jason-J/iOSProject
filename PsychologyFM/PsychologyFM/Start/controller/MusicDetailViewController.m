//
//  MusicDetailViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-8-5.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "CircleView.h"
#import "MyMoviePlayerViewController.h"
#import "UIImageView+WebCache.h"
#import "PlayerView.h"
#import "StartOrSuspendView.h"
#import "ControlView.h"
#import "TitleTabBarView.h"
@interface MusicDetailViewController ()
@property (nonatomic, retain) CircleView *circleView;
@property (nonatomic, retain) PlayerView *playerView;
@property (nonatomic, retain) MyMoviePlayerViewController *player;
@property (nonatomic, retain) UISlider *musicSlider;
@property (nonatomic, retain) ControlView *controlView;
//进度条时间
@property (nonatomic, retain) UILabel *currentTime;
@property (nonatomic, retain) UILabel *endTime;

@end

@implementation MusicDetailViewController
- (void)dealloc
{
    [_currentTime release];
    [_endTime release];
    [_musicSlider release];
    [_controlView release];
    [_circleView release];
    [_playerView release];
    [super dealloc];
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    self.playerView = [[[PlayerView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)] autorelease];
    self.playerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playerView];

    _circleView = [[[CircleView alloc] initWithFrame:CGRectMake(85, 100, 150, 150)] autorelease];
    _circleView.backgroundColor = [UIColor greenColor];
    [self.playerView addSubview:_circleView];
    [self.playerView setUserInteractionEnabled:YES];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.frame = CGRectMake(0, 20, 80, 40);
    [self.playerView addSubview:backBtn];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//当前播放时间
        self.currentTime = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80 - 40, 80, 20)] autorelease];
        self.currentTime.text = @"00:00";
        self.currentTime.textColor = [UIColor whiteColor];
        self.currentTime.textAlignment = 1;
        [self.playerView addSubview:self.currentTime];
//        结束时间
        self.endTime = [[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, self.currentTime.frame.origin.y, 80, 20)] autorelease];;
        self.endTime.textColor = [UIColor whiteColor];
        self.endTime.textAlignment = 1;
        self.endTime.text = @"00:00";
        [self.playerView addSubview:self.endTime];
        
//    进度条
    self.musicSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, 320, 40)];
//    musicControl.transform = CGAffineTransformMakeRotation(1.57079633);
    [self.playerView addSubview:self.musicSlider];
    [self.musicSlider addTarget:self action:@selector(musicSlider:) forControlEvents:UIControlEventValueChanged];


    _player = [MyMoviePlayerViewController shareInstance];
    [_player play];

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getDuration) userInfo:nil repeats:YES];

//    暂停按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.circleView addSubview:startBtn];
    [startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.frame = CGRectMake(0, 0, startBtn.superview.frame.size.width, startBtn.superview.frame.size.height);
    startBtn.layer.cornerRadius = startBtn.superview.frame.size.width / 2;

    if (_player.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        [_circleView circleTurn];
    } else {
        [_circleView circlePase];
    }
    
    
//    控制台
    self.controlView = [[ControlView alloc] initWithFrame:CGRectMake(0, _musicSlider.frame.origin.y + _musicSlider.frame.size.height - 10, self.view.frame.size.width, 40)];

    [self.playerView addSubview:self.controlView];

    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
//暂停／开始播放
-(void)startBtnAction:(UIButton *)button
{
    if ([self.player isStart]) {
        NSLog(@"播放");
        [self.player.moviePlayer play];
        self.player.isStart = NO;
        [_circleView circleTurn];
    } else {
        NSLog(@"暂停");
        [self.player.moviePlayer pause];
        self.player.isStart = YES;
        [_circleView circlePase];
    }
    
}
//进度条自动跳动
- (void)getDuration
{
    self.musicSlider.value = self.player.moviePlayer.currentPlaybackTime;
    self.currentTime.text = [NSString stringWithFormat:@"%d:%d", (int)_musicSlider.value / 60, (int)_musicSlider.value % 60];
    if ((int)_player.moviePlayer.currentPlaybackTime == (int)_player.moviePlayer.duration) {
        NSLog(@"end");
        
        //test
        if (_currentPlay + 2 == _FMListArray.count) {
            _currentPlay = 0;
        }
        FMTitle *article = [self.FMListArray objectAtIndex:_currentPlay ++];
        TitleTabBarView *titleTBV = [TitleTabBarView shareInstanceWithFrame:CGRectMake(0, 0, 320, 46)];
        titleTBV.viewData = (BaseModel *)article;
        self.navigationItem.titleView = titleTBV;
        StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
        view.article = article;
        //播放器
        MyMoviePlayerViewController *player = [MyMoviePlayerViewController     shareInstance];
        
        MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
        musicDetailVC.FMListArray = self.FMListArray;
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

        
        
        
        [_circleView circlePase];
    }
}
- (void)musicSlider:(UISlider *)slider
{
    _player.moviePlayer.currentPlaybackTime = slider.value;
    [_player.moviePlayer play];
}
- (void)backBtnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{

        
    }];
}
+ (MusicDetailViewController *)shareInstance
{
    static MusicDetailViewController *musicDetailVC = nil;
    if (!musicDetailVC) {
        musicDetailVC = [[MusicDetailViewController alloc] init];
    }
    return musicDetailVC;
}
- (void)setArticle:(FMTitle *)article
{
    if (_article != article) {
        [_article release];
        _article = [article retain];
        self.circleView.viewData = (BaseModel *)self.article;
        self.playerView.viewData = (BaseModel *)self.article;
        self.controlView.article = self.article;

    }
}
- (void)setDuration:(double)duration
{

    //      控制器
    _musicSlider.maximumValue = duration;
    [_circleView circleTurn];
    //总时长
    _endTime.text = [NSString stringWithFormat:@"%d:%d", (int)duration / 60, (int)duration% 60];
    NSLog(@"slider %f", self.player.moviePlayer.duration);
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    if (_player.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
//        [_circleView circlePase];
        [_circleView circleTurn];
    } else {
        [_circleView circlePase];
    }
    StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
    [view circlePase];
}
- (void)viewDidDisappear:(BOOL)animated
{
        [_circleView circlePase];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;

    StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
    [view circleTurn];
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
