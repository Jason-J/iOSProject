//
//  CollectionTitleView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "CollectionTitleView.h"

@interface CollectionTitleView ()
@property (nonatomic, retain) UILabel *colorLabel;

@property (nonatomic, retain) UIButton *moreBtn;
@end
@implementation CollectionTitleView
-(void)dealloc
{
    [_titleLabel release];
    [_colorLabel release];
    [_moreBtn release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _colorLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 10, frame.size.height)]autorelease];
        [self addSubview:_colorLabel];
        _colorLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, frame.size.height)] autorelease];
        _titleLabel.textAlignment = 1;
        _titleLabel.textColor = [UIColor orangeColor];
        [self addSubview:_titleLabel];
    }
    return self;
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
