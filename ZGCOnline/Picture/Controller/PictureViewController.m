//
//  PictureViewController.m
//  Zhongguancun
//
//  Created by jason on 14-7-7.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureView.h"
#import "Network.h"
#import "PictureListViewController.h"
@interface PictureViewController ()

@end

@implementation PictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"图赏";
        
        

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PictureView *picView = [[[PictureView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:picView];
    NSString *urlStr = @"http://lib.wap.zol.com.cn/ipj/tushang.php?page=1&retina=2&vs=iph362&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252";
    [Network connectNetGetDataWithUrlString:urlStr complement:^(id result) {
        picView.aPagePictureList = [result objectForKey:@"list"];
    }];
    [picView valueWithPage:^(NSInteger page, NSString *requestType) {
        NSString *urlStr = nil;
        picView.requestType = requestType;
        if ([requestType isEqualToString:@"refresh"]) {
            urlStr = @"http://lib.wap.zol.com.cn/ipj/tushang.php?page=1&retina=2&vs=iph362&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252";
        } else if ([requestType isEqualToString:@"getNextPage"]) {
            NSLog(@"page = %d", page);
            urlStr = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/tushang.php?page=%@&retina=2&vs=iph362&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", [NSNumber numberWithInt:page+1]];
        }
        [Network connectNetGetDataWithUrlString:urlStr complement:^(id result) {
            picView.aPagePictureList = [result objectForKey:@"list"];

        }];
        
    }];
    [picView valueWithPicId:^(NSString *picId) {
        PictureListViewController *picListVC = [[PictureListViewController alloc] init];
        picListVC.pro_id = picId;
        NSLog(@"%@,", picId);
        [self.navigationController pushViewController:picListVC animated:YES];
        [picListVC release];
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
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
