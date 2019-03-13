//
//  HugePictureCell.m
//  ZGCOnline
//
//  Created by Jason on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "HugePictureCell.h"

@interface HugePictureCell  ()
@end
@implementation HugePictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.myImageView];
        [self.myImageView release];
        
        self.dateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel release];
        
        self.comLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.comLabel];
        [self.comLabel release];
        
        self.picNumLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.picNumLabel];
        [self.picNumLabel release];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(10, 44, 300, 150);
    self.titleLabel.frame = CGRectMake(10, 0, 300, 44);
    self.dateLabel.frame = CGRectMake(10, 200, 100, 20);
    self.picNumLabel.frame = CGRectMake(210, 200, 50, 20);
    self.comLabel.frame = CGRectMake(265, 200, 50, 20);
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
