//
//  MyselectfourpageCell.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "MyselectfourpageCell.h"

@implementation MyselectfourpageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.myImageView];
        [self.myImageView release];
        
        self.myLabel1 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel1];
        [self.myLabel1 release];
        
        self.myLabel2 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel2];
        [self.myLabel2 release];
        
        self.myLabel3 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel3];
        [self.myLabel3 release];
        
        self.myLabel4 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel4];
        [self.myLabel4 release];
        
        self.myLabel5 = [[UILabel alloc]init];
        [self.contentView addSubview:self.myLabel5];
        [self.myLabel5 release];
    }
    return self;
}


-(void)dealloc
{
    [_myImageView release];
    [_myLabel1 release];
    [_myLabel2 release];
    [_myLabel3 release];
    [_myLabel4 release];
    [_myLabel5 release];
    [super dealloc];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.myLabel1.frame = CGRectMake(10, 10, self.frame.size.width * 7 / 10, self.frame.size.height / 4);
    self.myLabel1.backgroundColor =[UIColor clearColor];
    
    self.myImageView.frame = CGRectMake(10, self.frame.size.height / 4, self.frame.size.width / 3, self.frame.size.height * 3 / 4.5);
    self.myImageView.backgroundColor = [UIColor clearColor];
    
    self.myLabel2.frame = CGRectMake(self.frame.size.width * 7 / 9, 10, self.frame.size.width / 3, self.frame.size.height / 4);
    self.myLabel2.backgroundColor = [UIColor clearColor];
    
    self.myLabel3.frame = CGRectMake(self.frame.size.width / 3 + 10, self.frame.size.height / 4 + 10 , self.frame.size.width * 3 / 5 - 20, self.frame.size.height / 5);
    self.myLabel3.backgroundColor = [UIColor clearColor];
    
    self.myLabel4.frame = CGRectMake(self.frame.size.width / 3 + 10, self.frame.size.height / 3 + self.frame.size.height / 5, self.frame.size.width * 3 / 5 - 20, self.frame.size.height / 5);
    self.myLabel4.backgroundColor = [UIColor clearColor];
    
    self.myLabel5.frame = CGRectMake(self.frame.size.width / 3 + 10, self.frame.size.height / 3 + (self.frame.size.height / 5) * 2, self.frame.size.width * 3 / 5 - 20, self.frame.size.height / 5);
    self.myLabel5.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
