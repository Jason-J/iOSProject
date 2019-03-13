//
//  MySelectCell.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "MySelectCell.h"

@implementation MySelectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.label  =[[UILabel alloc] init];
        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.label];
        [_label release];
        
        
    }
    return self;
}

- (void)dealloc
{
    [_label release];
    [super dealloc];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.contentView.bounds;
    
    
    
    
    
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
