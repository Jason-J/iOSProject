//
//  MyHeartViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "MyHeartViewController.h"
#import "MyMoviePlayerViewController.h"
#import "ShakeView.h"
#import "TagListViewController.h"
@interface MyHeartViewController ()
@property (nonatomic, retain) NSMutableArray *allTagArray;
@end

@implementation MyHeartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    label.textAlignment = 1;
    label.text = @"摇一摇，好心情！";
    self.navigationItem.titleView = label;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [imageView setImage:[UIImage imageNamed:@"shake.jpg"]];
    self.view = imageView;
    
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self readFromLocal];
}
- (void)readFromLocal
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tagPath = [docPath stringByAppendingPathComponent:@"tag.txt"];
    NSLog(@"归档路径 %@", tagPath);
    self.allTagArray= [NSKeyedUnarchiver unarchiveObjectWithFile:tagPath];
    NSLog(@"读出的数组长度是%d",self.allTagArray.count);
    [self getRadomTag];
}
//产生随机数
- (void)getRadomTag
{
    BOOL isTrue = true;
    while (isTrue) {
        int random1 = arc4random() % _allTagArray.count;
        int random2 = arc4random() % _allTagArray.count;
        int random3 = arc4random() % _allTagArray.count;
        NSLog(@"%d", random1);
        NSLog(@"%d", random2);
        NSLog(@"%d", random3);
        if (random1 != random2 && random1 != random3 && random2 != random3) {
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObject:[self.allTagArray objectAtIndex:random1]];
            [tempArray addObject:[self.allTagArray objectAtIndex:random2]];
            [tempArray addObject:[self.allTagArray objectAtIndex:random3]];
            ShakeView *shakeView = [[ShakeView alloc] initWithFrame:CGRectMake(0, 64, 240, self.view.frame.size.height)];
            
            shakeView.selectedArray = tempArray;
            self.view = shakeView;
            isTrue = false;
            [shakeView valueOfTag:^(NSString *tagName) {
                TagListViewController *tagListVC = [[TagListViewController alloc] init];
                tagListVC.name = tagName;
                [self.navigationController pushViewController:tagListVC animated:YES];
            }];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
