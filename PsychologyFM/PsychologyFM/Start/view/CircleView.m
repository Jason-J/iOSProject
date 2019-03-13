//
//  CircleView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-4.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "CircleView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Turn.h"
#import "FMTitle.h"
@interface CircleView  ()
@property (nonatomic, retain)UIImageView *myImageView;
@property (nonatomic, retain)FMTitle *article;
@end
@implementation CircleView
- (void)dealloc
{
    [_myImageView release];
    [_article release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myImageView = [[UIImageView alloc]init];
        [self addSubview:self.myImageView];
        [self.myImageView setUserInteractionEnabled:YES];
        self.myImageView.layer.cornerRadius = frame.size.width / 2;
        self.myImageView.layer.masksToBounds = YES;
        self.myImageView.backgroundColor = [UIColor grayColor];
        self.myImageView.image = [UIImage imageNamed:@"start.png"];
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2;
    }
    return self;
}
-(void)circleTurn
{
    [self.myImageView setImageWithURL:[NSURL URLWithString:self.article.cover]];
    self.myImageView = [self rotate360DegreeWithImageView:self.myImageView];
}
- (void) circlePase
{
    [self.myImageView.layer removeAllAnimations];
    self.myImageView.image = [UIImage imageNamed:@"start.png"];
}
-(void)setViewData:(BaseModel *)viewData
{
    _article = (FMTitle *)viewData;
    self.myImageView.frame = CGRectMake(0, 0, 150, 150);
    [self.myImageView setImageWithURL:[NSURL URLWithString:self.article.cover]];
//    [self circleTurn];

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
