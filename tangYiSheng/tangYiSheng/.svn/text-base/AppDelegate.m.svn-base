//
//  AppDelegate.m
//  tangYiSheng
//
//  Created by Jason on 14-9-11.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "QuestionViewController.h"
#import "MyPatientViewController.h"
#import "MyNewsViewController.h"
#import "MineViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    问题模块
    QuestionViewController *questionVC = [[[QuestionViewController alloc] init] autorelease];
    UINavigationController *questionNavi = [[UINavigationController alloc] initWithRootViewController:questionVC];
    questionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"问题" image:[UIImage imageNamed:@"wenti.png"] tag:100 ];
    [questionVC.tabBarItem release];
    [questionVC.tabBarController setHidesBottomBarWhenPushed:YES];
    
    
//    患者模块
    MyPatientViewController  *myPatientVC = [[[MyPatientViewController alloc] init] autorelease];
    UINavigationController *mypatientNavi = [[UINavigationController alloc] initWithRootViewController:myPatientVC];
    myPatientVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"患者" image:[UIImage imageNamed:@"huanzhe.png"] tag:200];
    [myPatientVC.tabBarItem release];
    [myPatientVC.tabBarController setHidesBottomBarWhenPushed:YES];
    
    
//消息模块
    MyNewsViewController *myNewsVC = [[[MyNewsViewController alloc] init] autorelease];
    UINavigationController *myNewsNavi = [[UINavigationController alloc] initWithRootViewController:myNewsVC];
    myNewsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"xinxi.png"] tag:300];
    [myNewsVC.tabBarItem release];
    [myNewsVC.tabBarController setHidesBottomBarWhenPushed: YES];
    

// 我的模块
    MineViewController *mineVC = [[[MineViewController alloc] init] autorelease];
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"wode.png"] tag:400  ];
    [mineVC.tabBarItem release];
    [myNewsVC.tabBarController setHidesBottomBarWhenPushed:YES];
    
    
//    控制器
    NSArray *naviArray = [NSArray  arrayWithObjects:questionNavi, mypatientNavi, myNewsNavi, mineNavi, nil];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:naviArray animated:YES];
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    


    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is ab  out to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
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
