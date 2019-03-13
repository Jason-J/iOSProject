//
//  TagListViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-8-11.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "TagListViewController.h"
#include "FMTitle.h"
#import "TagListView.h"
#import "Network.h"
@interface TagListViewController ()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, retain) TagListView *tagListView;
@property (nonatomic, retain) NSMutableArray *tempArray;

@end

@implementation TagListViewController
-(void)dealloc
{

    [_name release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.page = 0;
        self.tempArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"-- %@", self.name);

    self.tagListView = [[TagListView alloc] initWithFrame:self.view.bounds];
    [self getData];
    self.view = self.tagListView;
    [self.tagListView valueOfPage:^(NSInteger page) {
        self.page = page;
        [self getData];
    }];
}
- (void)getData
{
    NSString *strUrl = [NSString stringWithFormat:@"http://bapi.xinli001.com/fm/broadcasts.json/?tag=%@&rows=10&key=9f3f57a7483a05ec42ecd912549276f0&offset=%d&speaker_id=0", self.name, self.page];
    if (0 == self.page) {
        [self.tempArray removeAllObjects];
    }
    [Network connectNetGetDataWithUrlString:strUrl complement:^(id result) {
        for (int i = 0; i < [[result objectForKey:@"data"] count]; i ++) {
            FMTitle *article = [[FMTitle alloc] init];
            [article setValuesForKeysWithDictionary:[[result objectForKey:@"data"] objectAtIndex:i]];
            [self.tempArray addObject:article];
        }
        self.tagListView.tagListArray = self.tempArray;
        
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
