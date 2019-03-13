//
//  PictureListViewCell.m
//  ZGCOnline
//
//  Created by Jason on 14-7-14.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "PictureListViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PictureListViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        self.myImageView = [[[UIImageView alloc] init] autorelease];
        [self.contentView addSubview:self.myImageView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    self.myImageView.frame = self.contentView.bounds;
}
- (void)setImageWithImageUrlStr:(NSString *)string
{
    [self.myImageView setImageWithURL:[NSURL URLWithString:string]];
}
-(void)dealloc
{
    [self.myImageView release];
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
