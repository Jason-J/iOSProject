//
//  SearchBarViewController.m
//  ZGCOnline
//
//  Created by Jason on 14-7-15.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "SearchBarViewController.h"
#import "ArticleListView.h"

#import "ArticleListView.h"
#import "Network.h"
@interface SearchBarViewController ()<UISearchDisplayDelegate>
@property (nonatomic, retain) ArticleListView *searchResultView;
@end

@implementation SearchBarViewController

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
    
    NSLog(@"%@ --%@--%@", self.search_text, self.bbsid, self.bid);
    
    self.searchResultView = [[[ArticleListView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:self.searchResultView];
    NSString *str = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/list.php?bbsid=%@&bid=%@&page=1&keyword=%@&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.bbsid, self.bid, self.search_text];
    [Network connectNetGetDataWithUrlString:str complement:^(id result) {
                self.searchResultView.aPageArticleList = [result objectForKey:@"list"];
        NSLog(@"%d", [self.searchResultView.aPageArticleList count]);
        
        
    }];
    
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
