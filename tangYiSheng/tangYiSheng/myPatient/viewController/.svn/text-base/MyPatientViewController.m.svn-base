//
//  MyPatientViewController.m
//  tangYiSheng
//
//  Created by Jason on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "MyPatientViewController.h"
#import "PatientDetailViewController.h"
#import "CellForPatient.h"
@interface MyPatientViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *patientListTableView;
@end

@implementation MyPatientViewController
- (void)dealloc
{
    [_patientListTableView release];
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
    self.title = @"患者";
    
    //患者列表
    _patientListTableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    [self.view addSubview:_patientListTableView];
    _patientListTableView.delegate = self;
    _patientListTableView.dataSource = self;
    [_patientListTableView registerClass:[CellForPatient class] forCellReuseIdentifier:@"reuse"];
    

    
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
    PatientDetailViewController *patientDetailVC = [[PatientDetailViewController alloc] init];
    [self.navigationController pushViewController:patientDetailVC animated:YES];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
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
