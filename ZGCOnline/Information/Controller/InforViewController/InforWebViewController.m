//
//  InforWebViewController.m
//  ZGCOnline
//
//  Created by Lee on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "InforWebViewController.h"
#import <Comment/Comment.h>

@interface InforWebViewController ()

@property (nonatomic, retain) UIView *myView;
@end

@implementation InforWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"详细内容";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    SSCCommentToolbar *toolBar = [self showCommentToolbarWithContentId:@"123" title:@"评论页面"];
    
    [toolBar setBackEvent:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];


    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height - toolBar.frame.size.height - 64)];

    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/client_article.php?id=%@&page=1&nightMode=0&picOpen=1&fontSize=2&ssid=nul", self.webID]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    

    
    
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
