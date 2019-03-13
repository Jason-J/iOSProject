//
//  ConditionListViewController.m
//  ZGCOnline
//
//  Created by Jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ConditionListViewController.h"
#import "ConditionList.h"
#import "ArticleListViewController.h"
#import "Network.h"

@interface ConditionListViewController ()
@property (nonatomic, retain) ConditionList *listView;
@end

@implementation ConditionListViewController

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
    self.listView = [[[ConditionList alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:self.listView];
    self.listView.leftArray = self.leftArray;
    self.listView.tempArray = self.tempArray;
    

    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    [Network connectNetGetDataWithUrlString:self.urlStr complement:^(id result) {
        self.leftArray = [result objectAtIndex:1];
        self.tempArray = [result objectAtIndex:2];

        
    }];
    
    
    [self.listView valueOfCateidOrBid:^(id result, NSString *name) {
        
        
        ArticleListViewController *articleListVC = [[ArticleListViewController alloc] init];
        articleListVC.title = name;
        articleListVC.bid = result;
        articleListVC.bbsid = self.bbsid;
        [self.navigationController pushViewController:articleListVC animated:YES];
        [articleListVC release];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setLeftArray:(NSArray *)leftArray
{
    if (_leftArray != leftArray) {
        [_leftArray release];
        _leftArray = [leftArray retain];
        self.listView.leftArray = self.leftArray;
    }
}
- (void)setTempArray:(NSArray *)tempArray
{
    if (_tempArray != tempArray) {
        [_tempArray release];
        _tempArray = [tempArray retain];
        self.listView.tempArray = self.tempArray;
    }
}
-(void)setRightArray:(NSArray *)rightArray
{
    if (_tempArray != rightArray) {
        [_tempArray release];
        _tempArray = [rightArray retain];
        self.listView.tempArray = self.tempArray;
        
    }
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
