//
//  StartOrSuspendView.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "StartOrSuspendView.h"
#import "PlayerViewController.h"
#import "UIView+Turn.h"
#import "UIImageView+WebCache.h"
#import "MyMoviePlayerViewController.h"
#import "MusicDetailViewController.h"
@interface StartOrSuspendView ()
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIButton *radioBtn;
@end
@implementation StartOrSuspendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        button 的大小与view 一样
        self.radioBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.radioBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.layer.cornerRadius = self.frame.size.height / 2;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.imageView.layer.borderWidth = 2;
        [self.imageView setUserInteractionEnabled:YES];
        [self.imageView setImage:[UIImage imageNamed:@"start.png"]];
        [self addSubview:self.imageView];
        [self.imageView addSubview:self.radioBtn];
        [self.radioBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
}
    return self;
}
- (void)circleTurn
{
    
    [self.imageView rotate360DegreeWithImageView:self.imageView];
}
- (void)circlePase
{
    [self.imageView.layer removeAllAnimations];
}
- (void)setArticle:(FMTitle *)article
{
    if (_article != article) {
        [_article release];
        _article = [article retain];
        [self.imageView setImageWithURL:[NSURL URLWithString:article.cover]];
    }
}
- (void)buttonAction:(UIButton *)button
{
    
    
    UIViewController *viewController = [self viewController];
    MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
    musicDetailVC.article = self.article;
    if (self.article) {
        [viewController presentViewController:musicDetailVC animated:YES completion:^{
            
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前没有播放FM,快从播放列表选择你想听的FM吧😄！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

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

+(StartOrSuspendView *)shareInstanceWithFrame:(CGRect)frame
{
    static StartOrSuspendView *start = nil;
    if (!start) {
        
        start = [[StartOrSuspendView alloc] initWithFrame:frame];
    }
    return start;
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
