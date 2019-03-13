//
//  ForumViewController.m
//  Zhongguancun
//
//  Created by jason on 14-7-7.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ForumViewController.h"
#import "RootOfForum.h"
#import "Network.h"
#import "ConditionListViewController.h"
@interface ForumViewController ()

@end

@implementation ForumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"论坛";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    RootOfForum *rootOfForum = [[RootOfForum alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:rootOfForum];
    
    [rootOfForum valueWithBlock:^(NSString *buttonStr) {
        NSString *urlStr = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/forum_ios3.1.1.php?bbsid=%@&UserIMEI=827fcc1aa68417c7df66e6989a667be8f8629c59", buttonStr];
        ConditionListViewController *listVC = [[ConditionListViewController alloc] init];
        listVC.urlStr = urlStr;
        listVC.bbsid = buttonStr;
        [self.navigationController pushViewController:listVC animated:YES];
        [listVC release];
        
    }];
    
    [rootOfForum release];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
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
