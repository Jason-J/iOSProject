//
//  ViewController.m
//  DelegateDemo
//
//  Created by Jax on 2019/3/14.
//  Copyright © 2019 大鑫哥. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()<protocoDelegate>
@property (nonatomic, strong) UILabel *label;
@property (strong, nonatomic) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    [self.view addSubview:_label];
//    _label.backgroundColor = [UIColor grayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"测试";
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 160, 200, 40);
    [self.view addSubview:_button];
    _button.center = CGPointMake(self.view.center.x, _button.center.y);
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"跳转" forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor redColor];
    
}
-(void)buttonAction:(UIButton *)button
{
    NSLog(@"action");
    SecondViewController *vc = [[SecondViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getSomeThing:(NSString *)string{
    _label.text = string;
}
@end
