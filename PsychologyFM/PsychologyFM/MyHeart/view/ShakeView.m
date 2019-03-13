//
//  ShakeView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-11.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "ShakeView.h"
#import "SceneModel.h"
#import "UIImageView+WebCache.h"
@implementation ShakeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selectedArray = [NSMutableArray array];

        
    }
    return self;
}
- (void)setSelectedArray:(NSMutableArray *)selectedArray
{
    if (_selectedArray != selectedArray) {
        [_selectedArray release];
        _selectedArray = [selectedArray retain];
        for (int i = 0; i < _selectedArray.count; i++) {
            SceneModel *scene = [_selectedArray objectAtIndex:i];
            NSLog(@"%@", scene.name);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            CGSize size = CGSizeMake(100, 100);
            CGPoint p = [self getButtonPoint];
            p.y = i * 100 + 100;
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(p.x, p.y, size.width, size.height)];
//            [imageView setUserInteractionEnabled:YES];
            [imageView setImageWithURL:[NSURL URLWithString:[scene cover]]];
            imageView.layer.cornerRadius = size.width / 2;
            imageView.layer.masksToBounds = YES;
            button.frame = CGRectMake(p.x, p.y, size.width, size.height);
            button.layer.cornerRadius = size.width / 2;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:scene.name forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, size.width, 30)];
            label.textAlignment = 1;
            [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            label.text = scene.name;
            label.textColor = [UIColor whiteColor];
            [imageView addSubview:label];
            [self addSubview:imageView];
            [self addSubview:button];
        }
        
    }
}
- (void)buttonAction:(UIButton *)button
{
    NSLog(@"%@", button.titleLabel.text);
    self.tagName(button.titleLabel.text);
}
-(void)valueOfTag:(TAGBLOCK)tagName
{
    self.tagName = tagName;
}
- (CGPoint)getButtonPoint
{
    float w = arc4random() % 240;
    CGPoint p = CGPointMake(w, 0);
    return p;
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
