//
//  TitleView.m
//  PsychologyFM
//
//  Created by Jason on 14-7-30.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "TitleView.h"
#import "FMTitle.h"
@implementation TitleView
-(void)dealloc
{
    [_titleLabel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 200, 40)];
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}
- (void)setTitleLabel:(UILabel *)titleLabel
{
    if (_titleLabel != titleLabel) {
        [_titleLabel release];
        _titleLabel = [titleLabel retain];
        FMTitle *article = [[FMTitle alloc] init];
        self.titleLabel.text = article.title;
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
