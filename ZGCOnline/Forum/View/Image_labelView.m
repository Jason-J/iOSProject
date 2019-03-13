//
//  Image_labelView.m
//  ZGCOnline
//
//  Created by Jason on 14-7-15.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "Image_labelView.h"

@implementation Image_labelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)] autorelease];
        [self addSubview:self.imageView];
        
        self.myTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 30)] autorelease];
        [self.myTitleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myTitleLabel.textAlignment = 1;
        [self addSubview:self.myTitleLabel];
        
        
    }
    return self;
}
- (void)dealloc {
    [self.myTitleLabel release];
    [self.imageView release];
    [super dealloc];
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
