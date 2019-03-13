//
//  ListCell.m
//  ZGCOnline
//
//  Created by Jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.myLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel];
        [self.myLabel release];
        self.myLabel.textAlignment = 0;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myLabel.frame = CGRectMake(20, 0, 180, 40);
}
- (void)dealloc
{
    [self.myLabel release];
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
