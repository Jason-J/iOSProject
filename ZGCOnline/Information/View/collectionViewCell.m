//
//  collectionViewCell.m
//  ZGCOnline
//
//  Created by Lee on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "collectionViewCell.h"

@implementation collectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.label = [[UILabel alloc] init];
        self.label.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.label.layer.cornerRadius = 6;
        [self.contentView addSubview:self.label];
       
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100 , 145)];
        view.backgroundColor = [UIColor yellowColor];
        view.alpha = 0.3;
        
        self.selectedBackgroundView = view;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
}

-(void)dealloc
{
    [_label release];
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
