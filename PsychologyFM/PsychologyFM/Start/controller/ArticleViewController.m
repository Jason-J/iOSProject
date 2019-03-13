//
//  ArticleViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-8-6.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()<UIWebViewDelegate>
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIView *titleView;

@end

@implementation ArticleViewController
-(void)dealloc
{
    [_article release];
    [_titleLabel release];
    [_webView release];
    [_titleView release];
    [super dealloc];
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
    self.titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)] autorelease];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 0, 80, 40);
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [self.titleView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(80, 0, self.view.frame.size.width - 80, 40)] autorelease];
    [self.titleView addSubview:self.titleLabel];
    
   

}
- (void)backBtnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}
- (void)setArticle:(FMTitle *)article
{
    if (_article != article) {
        [_article release];
        _article = [article retain];
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
        self.webView.delegate = self;
        NSURL *url = [NSURL URLWithString:_article.word_url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.webView];

    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementByIdx_xx_x_x('xxxx').innerHTML; "];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"(function(){window.baseUrl='https://www.readability.com';window.readabilityToken='';var s=document.createElement('script');s.setAttribute('type','text/javascript');s.setAttribute('charset','UTF-8');s.setAttribute('src',baseUrl+'/bookmarklet/read.js');document.documentElement.appendChild(s);})()"];

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
