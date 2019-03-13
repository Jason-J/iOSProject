//
//  MyAddDetailCellTableViewCell.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-10.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "MyAddDetailCellTableViewCell.h"

@implementation MyAddDetailCellTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.myLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel];
        [self.myLabel release];
        
        self.myLabel1 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel1];
        [self.myLabel1 release];
    }
    return self;
}
-(void)dealloc
{
    [_myLabel1 release];
    [_myLabel release];
    [super dealloc];
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.myLabel.frame = CGRectMake(20, -14, 240, self.frame.size.height * 2 / 2);
    //self.myLabel.backgroundColor = [UIColor redColor];
    self.myLabel1.frame = CGRectMake(20, self.frame.size.height / 2 - 2, 240, self.frame.size.height / 2 );
    self.myLabel1.font = [UIFont systemFontOfSize:14];
    //self.myLabel1.backgroundColor = [UIColor yellowColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

