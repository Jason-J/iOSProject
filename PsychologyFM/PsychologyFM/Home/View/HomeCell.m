//
//  HomeCell.m
//  PsychologyFM
//
//  Created by Jason on 14-7-30.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"
#import "FMTitle.h"
@implementation HomeCell
-(void)dealloc
{
    [_myImageView release];
    [_myTitleLabel release];
    [_anchorLabel release];
    [_collectionNumLabel release];
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.myImageView = [[UIImageView alloc] init];
        self.myTitleLabel = [[UILabel alloc] init];
        self.anchorLabel = [[UILabel alloc] init];
        self.collectionNumLabel = [[UILabel alloc] init];
        self.anchorLabel.font = [UIFont systemFontOfSize:10];
        self.collectionNumLabel.font = [UIFont systemFontOfSize:10];
        
        //测试颜色
//        self.myTitleLabel.backgroundColor = [UIColor redColor];
//        self.myImageView.backgroundColor = [UIColor grayColor];
//        self.anchorLabel.backgroundColor = [UIColor orangeColor];
//        self.collectionNumLabel.backgroundColor = [UIColor yellowColor];
        
        
        
        [self.contentView addSubview:self.myImageView];
        [self.contentView addSubview:self.myTitleLabel];
        [self.contentView addSubview:self.anchorLabel];
        [self.contentView addSubview:self.collectionNumLabel];
        [_myTitleLabel release];
        [_myImageView release];
        [_anchorLabel release];
        [_collectionNumLabel release];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(5, 5, 90, 90);
    self.myTitleLabel.frame = CGRectMake(120, 10, 190, 40);
    self.anchorLabel.frame = CGRectMake(120, 70, 90, 20);
    self.collectionNumLabel.frame = CGRectMake(230, 70, 90, 20);
}
- (void)setCellData:(BaseModel *)cellData
{
    [super setCellData:cellData];
    FMTitle *article = (FMTitle *)cellData;
    [self.myImageView setImageWithURL:[NSURL URLWithString:article.cover]];
    self.myTitleLabel.text = article.title;
    self.anchorLabel.text = [NSString stringWithFormat:@"主播 : %@", article.speak];
    self.collectionNumLabel.text = [NSString stringWithFormat:@"收藏❤️ : %@", article.favnum];
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
