//
//  InforSecondViewController.m
//  ZGCOnline
//
//  Created by Lee on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "InforSecondViewController.h"
#import "collectionViewCell.h"

@interface InforSecondViewController ()

@property (nonatomic, retain) UICollectionView *collectionView1;
@property (nonatomic, retain) UICollectionView *collectionView2;

@property (nonatomic, retain) collectionViewCell *cell1;
@property (nonatomic, retain) collectionViewCell *cell2;

@end

@implementation InforSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        self.didCollectionArray = [NSMutableArray array];
        self.moreCollectionArray = [NSMutableArray array];
//       self.navigationItem.leftBarButtonItem = [[UINavigationItem alloc] initWithTitle:@"information"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 64, 100, 30)];
    label1.text = @"已添加频道";
    label1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
   
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(50, 40);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 10;
   
    
    self.collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(40, 94, 240, 190) collectionViewLayout:flowLayout];
    self.collectionView1.dataSource = self;
    self.collectionView1.delegate = self;
    self.collectionView1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView1];
    [self.collectionView1 release];
    [self.collectionView1 registerClass:[collectionViewCell class] forCellWithReuseIdentifier:@"collectionReuse1"];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 285, 200, 20)];
    label.text = @"点击可添加或取消频道";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 310, 100, 30)];
    label2.text = @"更多频道";
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout2.itemSize = CGSizeMake(50, 40);
    flowLayout2.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout2.minimumInteritemSpacing = 5;
    flowLayout2.minimumLineSpacing = 10;
    
    self.collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(40, 340, 240, 200) collectionViewLayout:flowLayout2];
    self.collectionView2.dataSource = self;
    self.collectionView2.delegate = self;
    self.collectionView2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView2];
    [self.collectionView2 release];
    [self.collectionView2 registerClass:[collectionViewCell class] forCellWithReuseIdentifier:@"collectionReuse2"];
    

    
    [label1 release];
    [flowLayout release];
    [label2 release];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(barButtonAction:)];
}

- (void)barButtonAction: (UIButton *)button
{
    self.block(self.didCollectionArray);
    [self writeToLoad];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView1) {
        return [self.didCollectionArray count];
    } else {
        return [self.moreCollectionArray count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView1) {
        
        self.cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionReuse1" forIndexPath:indexPath];
        self.cell1.contentView.backgroundColor = [UIColor whiteColor];
        
        self.cell1.label.text = [[self.didCollectionArray objectAtIndex:indexPath.item] objectForKey:@"name"];
        // 本地读取
        
        
        
       // self.cell1.layer.borderWidth = 1.5;
       // self.cell1.layer.borderColor = [[UIColor cyanColor]CGColor];
        self.cell1.label.textAlignment = NSTextAlignmentCenter;
        return self.cell1;
    } else {
        self.cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionReuse2" forIndexPath:indexPath];
        self.cell2.contentView.backgroundColor = [UIColor whiteColor];
        self.cell2.label.text = [[self.moreCollectionArray objectAtIndex:indexPath.item] objectForKey:@"name"];
       // self.cell2.layer.borderWidth = 1.5;
       //self.cell2.layer.borderColor = [[UIColor cyanColor]CGColor];
        self.cell2.label.textAlignment = NSTextAlignmentCenter;
        return self.cell2;
    }
    
   
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.collectionView1) {
        NSLog(@"%@", self.didCollectionArray);

        for (NSDictionary *dic in self.didCollectionArray) {
            if ([[dic objectForKey:@"name"] isEqualToString:[[self.didCollectionArray objectAtIndex:indexPath.item] objectForKey:@"name"] ]) {
                [self.moreCollectionArray addObject:dic];
                [self.didCollectionArray removeObject:dic];
//                NSLog(@"more:%@", self.moreCollectionArray);
                
              
                
                [self.collectionView1 reloadData];
                [self.collectionView2 reloadData];
                break;
            }
        }
    }
    if (collectionView == self.collectionView2) {
//        NSLog(@"%@", self.didCollectionArray);
        
        for (NSDictionary *dic in self.moreCollectionArray) {
            if ([[dic objectForKey:@"name"] isEqualToString:[[self.moreCollectionArray objectAtIndex:indexPath.item] objectForKey:@"name"] ]) {
                [self.didCollectionArray addObject:dic];
                [self.moreCollectionArray removeObject:dic];
//                NSLog(@"more:%@", self.moreCollectionArray);
                [self.collectionView1 reloadData];
                [self.collectionView2 reloadData];
                break;
            }
        }
    }
   
    
    // 通过block 将改变的数组回传

}

// 实现block方法
- (void)valueArray:(BLOCK1)block
{
    self.block = block;

}

- (void)writeToLoad
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *collectPath = [path stringByAppendingPathComponent:@"collectarray.plist"];
    NSString *arrayPath = [path stringByAppendingPathComponent:@"array.plist"];
    
    NSArray *collectarr = [NSArray arrayWithArray:self.didCollectionArray];
    NSArray *arr = [NSArray arrayWithArray:self.moreCollectionArray];
    
    [NSKeyedArchiver archiveRootObject:collectarr toFile:collectPath];
    [NSKeyedArchiver archiveRootObject:arr toFile:arrayPath];
    NSLog(@"qwe");
    
    NSLog(@"%@", collectPath);
    
}

- (void)dealloc
{
    Block_release(_block);
    [_collectionView1 release];
    [_collectionView2 release];
    [_didCollectionArray release];
    [_moreCollectionArray release];
    [super dealloc];
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
