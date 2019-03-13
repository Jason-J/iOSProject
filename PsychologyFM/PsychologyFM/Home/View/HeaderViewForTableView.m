//
//  HeaderViewForTableView.m
//  PsychologyFM
//
//  Created by Jason on 14-7-30.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "HeaderViewForTableView.h"
#import "UIImageView+WebCache.h"
#import "TitleTabBarView.h"
#import "MyMoviePlayerViewController.h"
#import "StartOrSuspendView.h"
@interface HeaderViewForTableView ()
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *anthorLabel;
@property (nonatomic, retain) UIImageView *imageView;

@end

@implementation HeaderViewForTableView
- (void)dealloc
{
    [_titleLabel release];
    [_anthorLabel release];
    [_imageView release];
    [_title release];
    
    [super dealloc];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        [_imageView release];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 40, 200, 40)];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [_titleLabel release];
        self.anthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, self.frame.size.height - 40, 100, 40)];
        self.anthorLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.anthorLabel];
        [_anthorLabel release];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:button];
        button.frame = button.superview.frame;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)buttonAction:(UIButton *)button
{
    NSLog(@"头条");
    UIViewController *viewController = [self viewController];
    NSLog(@"%@", viewController);
    TitleTabBarView *titleView = [TitleTabBarView shareInstanceWithFrame:CGRectMake(0, 0, 320, 46)];
    titleView.viewData = (BaseModel *)self.title;
    viewController.navigationItem.titleView = titleView;

    MyMoviePlayerViewController *player = [MyMoviePlayerViewController shareInstance];
    if ([player isStart]) {
        [player.moviePlayer stop];
        player.article = _title ;
        [player.moviePlayer play];
    } else {
        player.article = _title;
        [player.moviePlayer play];
    }
    
    StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
    view.article = _title;

}
- (void)setTitle:(FMTitle *)title
{
    
    if (_title != title) {
        [_title release];
        _title = [title retain];
        [self.imageView setImageWithURL:[NSURL URLWithString:self.title.cover]];
        self.titleLabel.text = self.title.title;
        self.anthorLabel.text = [NSString stringWithFormat:@"主播：%@", self.title.speak];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
