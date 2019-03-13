//
//  StartViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "StartViewController.h"
#import "StartOrSuspendView.h"
#import "CircleView.h"
#import "UIImageView+WebCache.h"
#import "MyMoviePlayerViewController.h"
@interface StartViewController ()
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) CircleView *circleView;
@end

@implementation StartViewController
- (void)dealloc
{
    [_backgroundImageView release];
    [_circleView release];
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
    _backgroundImageView = [[[UIImageView alloc] initWithFrame:self.view.frame] autorelease];
    [self.view addSubview:_backgroundImageView];
    _circleView = [[[CircleView alloc] initWithFrame:CGRectMake(85, 100, 150, 150)] autorelease];
    [_backgroundImageView addSubview:_circleView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    MyMoviePlayerViewController *player = [MyMoviePlayerViewController shareInstance];
    [player play];
}
- (void)setArticle:(FMTitle *)article
{
    if (_article != article) {
        [_article release];
        _article = [article retain];
        [_backgroundImageView setImageWithURL:[NSURL URLWithString:_article.background]];
        _circleView.viewData = (BaseModel *)_article;
        [_circleView circleTurn];
    }
}
+ (StartViewController *)shareInstance
{
    static StartViewController *startVC = nil;
    if (!startVC) {
        startVC = [[StartViewController alloc] init];
        
    }
    return startVC;
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
