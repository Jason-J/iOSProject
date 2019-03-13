//
//  AppDelegate.m
//  ZGCOnline
//
//  Created by jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "AppDelegate.h"
#import "InfoViewController.h"
#import "SelectPriceViewController.h"
#import "ForumViewController.h"
#import "PictureViewController.h"
#import "MineViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [ShareSDK registerApp:@"25368666399f"];
    
    
    [ShareSDK connectSinaWeiboWithAppKey:@"3201194191"
                               appSecret:@"0334252914651e8f76bad63337b3b78f"
                             redirectUri:@"http://appgo.cn"];
    
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    
    
    InfoViewController *infoVC = [[[InfoViewController alloc] init] autorelease];
    UINavigationController *infoNavi = [[[UINavigationController alloc] initWithRootViewController:infoVC] autorelease];
    
    
    infoNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:[UIImage imageNamed:@"infor.png"] tag:100];
    [infoNavi.tabBarController setHidesBottomBarWhenPushed:YES];
    SelectPriceViewController *selectPriceVC = [[[SelectPriceViewController alloc] init] autorelease];
    UINavigationController *selectPriceNavi = [[[UINavigationController alloc] initWithRootViewController:selectPriceVC] autorelease];
    selectPriceNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"查报价" image:[UIImage imageNamed:@"price.png"] tag:200];
    
    ForumViewController *forumVC = [[[ForumViewController alloc] init] autorelease];
    UINavigationController *forumNavi = [[[UINavigationController alloc] initWithRootViewController:forumVC] autorelease];
    forumNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"论坛" image:[UIImage imageNamed:@"forum.png"] tag:300];
    [forumNavi.tabBarController setHidesBottomBarWhenPushed:NO];
    PictureViewController *pictureVC = [[[PictureViewController alloc] init] autorelease];
    UINavigationController *pictureNavi = [[[UINavigationController alloc] initWithRootViewController:pictureVC] autorelease];
    pictureNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"图赏" image:[UIImage imageNamed:@"picture.png"] tag:400];

    MineViewController *mineVC = [[[MineViewController alloc] init] autorelease];
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"mine.png"] tag:500];
    
    
    
    NSArray *naviArray = [NSArray arrayWithObjects:infoNavi, selectPriceNavi, forumNavi, pictureNavi, mineNavi, nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:naviArray];
    
    //    tabBarController.tabBar.barTintColor = [UIColor blackColor];
    
//    navigationController颜色
    infoNavi.navigationBar.barTintColor = [UIColor colorWithRed:(4 * 16 + 14) / 255.0 green:(7 * 16 + 2) / 255.0 blue:(11 * 16 + 8) / 255.0 alpha:1];
    selectPriceNavi.navigationBar.barTintColor = [UIColor colorWithRed:(4 * 16 + 14) / 255.0 green:(7 * 16 + 2) / 255.0 blue:(11 * 16 + 8) / 255.0 alpha:1];
    forumNavi.navigationBar.barTintColor = [UIColor colorWithRed:(4 * 16 + 14) / 255.0 green:(7 * 16 + 2) / 255.0 blue:(11 * 16 + 8) / 255.0 alpha:1];
    pictureNavi.navigationBar.barTintColor = [UIColor colorWithRed:(4 * 16 + 14) / 255.0 green:(7 * 16 + 2) / 255.0 blue:(11 * 16 + 8) / 255.0 alpha:1];
    
    mineNavi.navigationBar.barTintColor = [UIColor colorWithRed:(4 * 16 + 14) / 255.0 green:(7 * 16 + 2) / 255.0 blue:(11 * 16 + 8) / 255.0 alpha:1];
    
    
    //    设置tabbar选中颜色
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:(4 * 16 + 14) / 255.0 green:(7 * 16 + 2) / 255.0 blue:(11 * 16 + 8) / 255.0 alpha:1];
    
    self.window.rootViewController = tabBarController;
    
    [_window release];
    [tabBarController release];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
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
