//
//  AlternatePlayViewCell.m
//  PsychologyFM
//
//  Created by Jason on 14-8-1.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "AlternatePlayViewCell.h"
#import "FMTitle.h"
#import "UIImageView+WebCache.h"
@interface AlternatePlayViewCell ()
@property (nonatomic, retain) UIImageView *myImageView;
@property (nonatomic, retain) UILabel *titleLbael;
@end
@implementation AlternatePlayViewCell
- (void)dealloc
{
    [_myImageView release];
    [_titleLbael release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myImageView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        [self.contentView addSubview:self.myImageView];
        self.myImageView.backgroundColor = [UIColor grayColor];
        
        self.titleLbael = [[[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 60, 320, 40)] autorelease];
        [self.myImageView addSubview:self.titleLbael];
        
        
    }
    return self;
}
- (void)setCellData:(BaseModel *)cellData
{
    FMTitle *article = (FMTitle *)cellData;
    [self.myImageView setImageWithURL:[NSURL URLWithString:article.cover]];
    
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
