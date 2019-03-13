//
//  BaseCell.m
//  tangYiSheng
//
//  Created by Jason on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell
- (void)dealloc
{

    [super dealloc];
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
