//
//  MyMoviePlayerViewController.h
//  PsychologyFM
//
//  Created by Jason on 14-8-1.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "FMTitle.h"
#import "M3U8Handler.h"
#import "VideoDownloader.h"
#import "HTTPServer.h"


@interface MyMoviePlayerViewController : MPMoviePlayerViewController
@property (nonatomic, retain) FMTitle *article;
//播放器
@property (nonatomic, retain)HTTPServer *httpServer;
@property (nonatomic, retain)VideoDownloader *downloader;
@property (nonatomic, assign) BOOL isStart;//判断是否播放


+ (MyMoviePlayerViewController *)shareInstance;
- (void)play;


@end
