//
//  InforTableViewCell1.m
//  ZGCOnline
//
//  Created by Lee on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "InforTableViewCell1.h"



@implementation InforTableViewCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.MyimageView = [[UIImageView alloc] init];
        self.Mylabel1 = [[UILabel alloc] init];
        self.Mylabel2 = [[UILabel alloc] init];
        self.Mylabel3 = [[UILabel alloc] init];
        self.Mylabel3.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.MyimageView];
        [self.contentView addSubview:self.Mylabel1];
        [self.contentView addSubview:self.Mylabel2];
        [self.contentView addSubview:self.Mylabel3];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.MyimageView.frame = CGRectMake(5, 10, 100, 70);
    self.Mylabel1.frame = CGRectMake(120, 5, 190, 0);
    self.Mylabel1.numberOfLines = 0;
    [self.Mylabel1 sizeToFit];
    
    self.Mylabel2.frame = CGRectMake(120, 55, 50, 20);
    self.Mylabel3.frame = CGRectMake(240, 55, 70, 20);
    self.Mylabel2.font = [UIFont systemFontOfSize:15];
    self.Mylabel3.font = [UIFont systemFontOfSize:15];
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
