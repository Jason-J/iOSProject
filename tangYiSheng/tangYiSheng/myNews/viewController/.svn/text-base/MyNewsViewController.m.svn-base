//
//  MyNewsViewController.m
//  tangYiSheng
//
//  Created by Jason on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "MyNewsViewController.h"
#import "AnswerQuestionViewController.h"
@interface MyNewsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *questionListTableView;

@end

@implementation MyNewsViewController
- (void)dealloc
{
    [_questionListTableView release];
    [super dealloc];
    
}
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
    
    self.title = @"消息";
    
    //选择开关
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"待解答", @"回复我的"]];
    segment.frame = CGRectMake(10, 80, self.view.frame.size.width - 20, 40);
    [self.view addSubview:segment];
    [segment release];
    
    //问题列表
    _questionListTableView = [[[UITableView alloc] initWithFrame:CGRectMake(10, 140, self.view.frame.size.width - 20, self.view.frame.size.height - 184) style:UITableViewStylePlain] autorelease];
    [self.view addSubview:_questionListTableView];
    _questionListTableView.delegate = self;
    _questionListTableView.dataSource = self;
    [_questionListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    

    
}

#pragma mark - tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    cell.textLabel.text  = @"test";
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnswerQuestionViewController *answerQuestionVC = [[AnswerQuestionViewController alloc] init];
    [self.navigationController pushViewController: answerQuestionVC animated:YES];
    
    
    
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
