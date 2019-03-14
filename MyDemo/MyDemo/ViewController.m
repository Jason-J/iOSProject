//
//  ViewController.m
//  MyDemo
//
//  Created by Jax on 2019/3/7.
//  Copyright © 2019 NoName. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
@protocol myProtocol <NSObject>
-(void)meth;
@optional
-(int)meth2;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSObject
    int a = 22;
    int b = 32;
    int avg = 0;
    NSLog(@"avg = %d", avg);
    int c = [self scanfnum1:a AndNum2:b AndAvg:&avg];
    NSLog(@"a = %d, b = %d, c = %d , avg = %d", a, b ,c, avg);
}

-(int)scanfnum1:(int)num1 AndNum2:(int)num2 AndAvg:(int *)avg{
    *avg = (num1+num2) / 2;
    if (num1 > num2){
        
        return num1 ;
    }else return num2;
    
}

@end
