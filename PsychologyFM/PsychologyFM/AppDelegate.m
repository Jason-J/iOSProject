//
//  AppDelegate.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MyHeartViewController.h"
#import "StartViewController.h"
#import "SelectAllViewController.h"
#import "OptionViewController.h"
#import "StartOrSuspendView.h"
#import <AVFoundation/AVFoundation.h>
#import "MyMoviePlayerViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MyMoviePlayerViewController *myPlay = [MyMoviePlayerViewController shareInstance];
    [myPlay.moviePlayer play];

    
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"最新" image:[UIImage imageNamed:@"home.png"] tag:100];
    
    MyHeartViewController *myHeartVC = [[MyHeartViewController alloc] init];
    myHeartVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"随心" image:[UIImage imageNamed:@"myHeart.png"] tag:200];
    UINavigationController *myHeartNavi = [[UINavigationController alloc] initWithRootViewController:myHeartVC];
    
    StartViewController *startVC = [StartViewController shareInstance];
    UINavigationController *startNavi = [[UINavigationController alloc] initWithRootViewController:startVC];
    
    
//    MyMoviePlayerViewController *playerVC = [MyMoviePlayerViewController shareInstance];
//    UINavigationController *startNavi = [[UINavigationController alloc] initWithRootViewController:playerVC];
    
    SelectAllViewController *selectAllVC = [[SelectAllViewController alloc] init];
    selectAllVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"寻找" image:[UIImage imageNamed:@"find.png"] tag:400];
    UINavigationController *selectAllNavi = [[UINavigationController alloc] initWithRootViewController:selectAllVC];
    
    
    OptionViewController *optionVC = [[OptionViewController alloc] init];
    optionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"option.png"] tag:500];
    UINavigationController *optionNavi = [[UINavigationController alloc] initWithRootViewController:optionVC];
    
    NSArray *viewControllerArray = @[homeNavi, myHeartNavi, startNavi, selectAllNavi, optionNavi];
    
    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    tabBarC.viewControllers = viewControllerArray;
    tabBarC.tabBar.tintColor = [UIColor orangeColor];
    
//    控制播放按钮
    StartOrSuspendView *startView = [StartOrSuspendView shareInstanceWithFrame:CGRectMake(0, - 10, 64, 64)];

    [[tabBarC.tabBar.subviews objectAtIndex:2] addSubview:startView];
    self.window.rootViewController = tabBarC;
    [homeNavi release];
    [myHeartNavi release];
    [startNavi release];
    [selectAllNavi release];
    [optionNavi release];
    [tabBarC release];
    [homeVC release];
    [myHeartVC release];
    [startVC release];
    [selectAllVC release];
    [optionVC release];
//
//
    
    
    
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:homeVC];
//    self.window.rootViewController = navi;
//    
//    [navi release];
//    [homeVC release];
//    [_window release];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
