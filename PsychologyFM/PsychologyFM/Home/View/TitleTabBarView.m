//
//  TitleTabBarView.m
//  PsychologyFM
//
//  Created by Jason on 14-7-31.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "TitleTabBarView.h"
#import "FMTitle.h"
@interface TitleTabBarView ()
@property (nonatomic, retain) UILabel *titleLabel;
@end
@implementation TitleTabBarView
- (void)dealloc
{
    [_titleLabel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 40)];
        self.titleLabel.text = @"Welcome to爱❤️无限FM";
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
        self.titleLabel.textAlignment = 1;
        self.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
}
+(TitleTabBarView *)shareInstanceWithFrame:(CGRect)frame
{
    static TitleTabBarView *title = nil;
    if (!title) {
        title = [[TitleTabBarView alloc] initWithFrame:frame] ;
    }
    return title;
}
- (void)setViewData:(BaseModel *)viewData
{
    [super setViewData:viewData];
    FMTitle *title = (FMTitle *)viewData;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.text = [NSString stringWithFormat:@"当前播放：%@", title.title];
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
