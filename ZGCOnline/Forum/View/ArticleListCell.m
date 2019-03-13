//
//  ArticleListCell.m
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ArticleListCell.h"

@interface ArticleListCell ()
@property (nonatomic, retain) UIView *myView;
@property (nonatomic, retain) UILabel *articleTitleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *commentLabel;
@end
@implementation ArticleListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.articleTitleLabel = [[[UILabel alloc] init] autorelease];
        [self.contentView addSubview:self.articleTitleLabel];
        self.authorLabel = [[[UILabel alloc] init] autorelease];
        [self.contentView addSubview:self.authorLabel];
        self.commentLabel = [[[UILabel alloc] init] autorelease];
        [self.contentView addSubview:self.commentLabel];
        
        
        [self.authorLabel setFont:[UIFont systemFontOfSize:10]];
        [self.commentLabel setFont:[UIFont systemFontOfSize:10]];
        self.authorLabel.backgroundColor = [UIColor grayColor];
        self.commentLabel.backgroundColor = [UIColor grayColor];
        self.authorLabel.alpha = 0.5;
        self.commentLabel.alpha = 0.5;
        self.commentLabel.textAlignment = 1;
        [self.articleTitleLabel release];
        [self.authorLabel release];
        [self.commentLabel release];
        
    }
    return self;
}
- (void)addCellWithArticleTitle:(NSString *)title author:(NSString *)author comment:(NSString *)comment hits:(NSString *)hits
{

    self.articleTitleLabel.text = title;
    self.authorLabel.text = author;
    [self.commentLabel setFont:[UIFont systemFontOfSize:13]];
    NSString *str = [NSString stringWithFormat:@"回%@/点%@", comment, hits];
    self.commentLabel.text = str;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.articleTitleLabel.frame = CGRectMake(10, 10, 320, 40);
    self.authorLabel.frame = CGRectMake(10, 50, 100, 25);
    self.commentLabel.frame = CGRectMake(200, 50, 100, 25);
}
- (void)dealloc
{
    [_articleTitleLabel release];
    [_authorLabel release];
    [_commentLabel release];
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
