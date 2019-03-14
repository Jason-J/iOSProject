//
//  SecondViewController.m
//  DelegateDemo
//
//  Created by Jax on 2019/3/14.
//  Copyright © 2019 大鑫哥. All rights reserved.
//

#import "SecondViewController.h"




@interface SecondViewController ()



@property (strong, nonatomic) UITextField *textField;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    [self.view addSubview:_textField];
    _textField.backgroundColor = [UIColor yellowColor];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_delegate getSomeThing:_textField.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
