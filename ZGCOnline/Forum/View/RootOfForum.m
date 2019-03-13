//
//  RootOfForum.m
//  Zhongguancun
//
//  Created by jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "RootOfForum.h"
#import "Image_labelView.h"
@interface RootOfForum ()

@property (nonatomic, retain) NSMutableArray *buttonArray;


@end
@implementation RootOfForum


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        数码摄影论坛背景
        Image_labelView *shumaView = [[[Image_labelView alloc] initWithFrame:CGRectMake(60, 120, 100, 100)] autorelease];
        [self addSubview:shumaView];
        shumaView.myTitleLabel.text = @"数码摄影论坛";
        shumaView.imageView.image = [UIImage imageNamed:@"camera-icon.png"];
        shumaView.backgroundColor = [UIColor brownColor];

        
//        笔记本论坛背景
        Image_labelView *personCPView = [[[Image_labelView alloc] initWithFrame:CGRectMake(180, 120, 100, 100)] autorelease];
        [self addSubview:personCPView];
        personCPView.myTitleLabel.text = @"笔记本论坛";
        personCPView.imageView.image = [UIImage imageNamed:@"computer-icon.png"];
        personCPView.backgroundColor = [UIColor yellowColor];

//        手机论坛背景
        Image_labelView *phoneView = [[[Image_labelView alloc] initWithFrame:CGRectMake(60, 240, 100, 100)] autorelease];
        [self addSubview:phoneView];
        phoneView.myTitleLabel.text = @"手机论坛";
        phoneView.imageView.image = [UIImage imageNamed:@"phone-icon.png"];
        phoneView.backgroundColor = [UIColor greenColor];
        
//        硬件论坛背景
        Image_labelView *hardware = [[[Image_labelView alloc] initWithFrame:CGRectMake(180, 240, 100, 100)] autorelease];
        [self addSubview:hardware];
        hardware.myTitleLabel.text = @"硬件论坛";
        hardware.imageView.image = [UIImage imageNamed:@"hardware-icon.png"];
        hardware.backgroundColor = [UIColor purpleColor];
        
        
        self.buttonArray = [NSMutableArray array];
        for (int i = 0; i < 2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [self addSubview:button];
            button.frame = CGRectMake(60 + 40 * i + i * 80, 120, 100, 100);
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
        }
        for (int i = 0; i < 2; i++) {
            UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
            [self addSubview:button];
            button.frame = CGRectMake(60 + 40 * i + i * 80, 240, 100, 100);
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
        }
        
        
        
        
    }
    return self;
}

-(void)valueWithBlock:(ButtonBlock)block
{
    self.block = (block);
}
- (void)buttonClicked:(UIButton *)button
{
    NSString  *num = 0;
    if (button == self.buttonArray[0]) {
        num = @"1";
    } else if (button == self.buttonArray[1]) {
        num = @"2";
    } else if (button == self.buttonArray[2]) {
        num = @"3";
    } else {
        num = @"4";
    }
    self.block(num);
}
//-(void)setButtonArray:(NSMutableArray *)buttonArray
//{
//    if (_buttonArray != buttonArray) {
//        [_buttonArray release];
//        _buttonArray = [buttonArray retain];
//        
//    }
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
