//
//  PlayerView.m
//  PsychologyFM
//
//  Created by Jason on 14-7-31.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "PlayerView.h"
#import "FMTitle.h"
#import "UIImageView+WebCache.h"
#import "UIView+Turn.h"
@interface PlayerView ()
@property (nonatomic, retain) UILabel *titleLabel;
//@property (nonatomic, retain) UIImageView *myImageView;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UILabel *speakerLabel;

@end
@implementation PlayerView
- (void)dealloc
{
    [_titleLabel release];
//    [_myImageView release];
    [_speakerLabel release];
    [_backgroundImageView release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)] autorelease];
        label.backgroundColor = [UIColor whiteColor];
        
        self.backgroundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1920, 1200)] autorelease];
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView addSubview:label];
//        添加朦胧效果
        UIView *view = [[UIView alloc] initWithFrame:self.frame];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.1;
        [self.backgroundImageView addSubview:view];
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 240, 300, 40)] autorelease];
        self.titleLabel.textAlignment = 1;
        [self.backgroundImageView addSubview:self.titleLabel];
        self.speakerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 290, 300, 40)] autorelease];
        self.speakerLabel.textAlignment = 1;
        [self.backgroundImageView addSubview:self.speakerLabel];
//        self.myImageView.layer.cornerRadius = 50;
//        self.myImageView.layer.masksToBounds = YES;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.speakerLabel.textColor = [UIColor whiteColor];

    }
    return self;
}
- (void)setViewData:(BaseModel *)viewData
{
//    [super setViewData:viewData];
    FMTitle *article = (FMTitle *)viewData;
    NSLog(@"article = %@", article.title);
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:article.background] placeholderImage:[UIImage imageNamed:@"deafult.jpg"]];
    self.titleLabel.text = article.title;
    self.speakerLabel.text = [NSString stringWithFormat:@"主播:%@", article.speak];
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
