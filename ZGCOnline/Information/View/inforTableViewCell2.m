
//
//  inforTableViewCell2.m
//  ZGCOnline
//
//  Created by Lee on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "inforTableViewCell2.h"

@implementation inforTableViewCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.MyLabel1 = [[UILabel alloc] init];
        self.MyLabel2 = [[UILabel alloc] init];
        self.MyLabel3 = [[UILabel alloc] init];
        self.MyLabel4 = [[UILabel alloc] init];
        self.MyImageView1 = [[UIImageView alloc] init];
        self.MyIamgeView2 = [[UIImageView alloc] init];
        self.MyImageView3 = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.MyLabel1];
        [self.contentView addSubview:self.MyLabel2];
        [self.contentView addSubview:self.MyLabel3];
        [self.contentView addSubview:self.MyLabel4];
        [self.contentView addSubview:self.MyImageView1];
        [self.contentView addSubview:self.MyIamgeView2];
        [self.contentView addSubview:self.MyImageView3];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.MyLabel1.frame = CGRectMake(5, 5, 310, 30);
    self.MyLabel1.numberOfLines = 0;
    self.MyLabel2.frame = CGRectMake(5, 105, 50, 20);
    self.MyLabel3.frame = CGRectMake(210, 105, 50, 20);
    self.MyLabel4.frame = CGRectMake(265, 105, 50, 20);
    
    
    self.MyLabel2.font = [UIFont systemFontOfSize:15];
    self.MyLabel3.font = [UIFont systemFontOfSize:15];
    self.MyLabel4.font = [UIFont systemFontOfSize:15];
    
    self.MyImageView1.frame = CGRectMake(5, 40, 100, 60);
    self.MyIamgeView2.frame = CGRectMake(110, 40, 100, 60);
    self.MyImageView3.frame = CGRectMake(215, 40, 100, 60);
}


- (void)dealloc
{
    [_MyLabel1 release];
    [_MyLabel2 release];
    [_MyLabel3 release];
    [_MyLabel4 release];
    [_MyImageView1 release];
    [_MyIamgeView2 release];
    [_MyImageView3 release];
    [super dealloc];
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
