//
//  CustomizationListViewController.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "CustomizationListViewController.h"
#import "ParticularListViewController.h"
#import "Network.h"
#import "MySelectCell.h"
#import "MyAddDetailCellTableViewCell.h"


@interface CustomizationListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *array1;
@property (nonatomic, retain) NSDictionary *myDic;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arry;



@end

@implementation CustomizationListViewController

-(void)getData
{
    
    NSString *str1 = @"http://lib3.wap.zol.com.cn/index.php?c=Pro_Cate&showSubcate=1&noParam=1";
    
    [Network connectNetGetDataWithUrlString:str1 complement:^(id result) {
        //        NSLog(@"====%@", result);
        //        NSLog(@"------%d", [[result objectForKey:@"1"] count]);
        //
        
        
        
        self.arry  = [NSMutableArray array];
        for (int i = 1; i <= 16; i++) {
            NSMutableArray *array = [result objectForKey:[NSString stringWithFormat:@"%d", i]];
            [self.arry addObjectsFromArray:array];
            
        }
        for (int i = 0; i < 16; i++) {
            //            NSLog(@"++++++++%@", [[self.arry objectAtIndex:i] objectForKey:@"name"]);
        }
        
        
        [self.tableView reloadData];
    }];
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"产品定制";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    //    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [_tableView release];
    
    
    [self getData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *str1 = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str1] autorelease];
    }
    
    cell.textLabel.text = [[self.arry objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    
    
    //    cell.detailTextLabel.text = [[self.array1 objectAtIndex:indexPath.row] objectForKey:@"subNameStr"];
    
    
    //   NSLog(@"---------%@",cell.textLabel.text);
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arry count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParticularListViewController *Particular = [[ParticularListViewController alloc] init];
    
    Particular.pagearr = [[self.arry objectAtIndex:indexPath.row] objectForKey:@"subcateArr"];
    
    //    NSLog(@"________________%@",Particular.pagearr);
    
    [self.navigationController pushViewController:Particular animated:YES];
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [Particular release];
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
