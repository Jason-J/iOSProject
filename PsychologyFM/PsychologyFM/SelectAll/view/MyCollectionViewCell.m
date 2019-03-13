//
//  MyCollectionViewCell.m
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "SceneModel.h"
#import "UIImageView+WebCache.h"

@interface MyCollectionViewCell   ()
@property (nonatomic, retain) UIImageView *myImageView;
@property (nonatomic, retain) UILabel *tagLabel;
@end
@implementation MyCollectionViewCell
-(void)dealloc
{
    [_myImageView release];
    [_tagLabel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _myImageView = [[[UIImageView alloc] init] autorelease];
        [self.contentView addSubview:_myImageView];
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textAlignment = 1;
        _tagLabel.textColor = [UIColor whiteColor];
        [_myImageView addSubview:_tagLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.myImageView.frame = self.contentView.bounds;
    _tagLabel.frame = CGRectMake(0, _myImageView.frame.size.height - 30, _tagLabel.superview.frame.size.width, 30);
    
}
-(void)setCellData:(BaseModel *)cellData
{
    SceneModel *scene = (SceneModel *)cellData;
    [_myImageView setImageWithURL:[NSURL URLWithString:scene.cover]];
    _tagLabel.text = scene.name;
    
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
