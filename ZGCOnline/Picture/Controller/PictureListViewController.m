//
//  PictureListViewController.m
//  ZGCOnline
//
//  Created by Jason on 14-7-14.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "PictureListViewController.h"
#import "PictureListView.h"
#import "Network.h"
#import "Pictures.h"
@interface PictureListViewController ()

@end

@implementation PictureListViewController

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
    self.navigationItem.titleView.backgroundColor = [UIColor blackColor];
    NSString *urlStr = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/pic_tours/pic_list_ios.php?pro_id=%@&&size=640x960&UserIMEI=ab0f04171369ea0f912134c67a7823fc75b63252", self.pro_id];
    PictureListView *picListView = [[PictureListView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:picListView];
    [Network connectNetGetDataWithUrlString:urlStr complement:^(id result) {
        picListView.content = [result objectForKey:@"content"];
        NSLog(@"--- %@", [result objectForKey:@"content"]);
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0; i < [[result objectForKey:@"list"] count]; i ++) {
            Pictures *pic = [[Pictures alloc] init];
            [pic setValuesForKeysWithDictionary:[[result objectForKey:@"list"] objectAtIndex:i]];
            [tempArr addObject:pic];
        }
        NSLog(@"temp === %d", [tempArr count]);
        picListView.picArray = tempArr;
        NSLog(@"%d", [picListView.picArray count]);
        
    }];
    
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
