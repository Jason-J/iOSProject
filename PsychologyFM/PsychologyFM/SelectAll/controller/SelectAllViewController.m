//
//  SelectAllViewController.m
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "SelectAllViewController.h"
#import "FMTitle.h"
#import "SceneModel.h"
#import "Network.h"
#import "AlternatelyPlayView.h"
#import "AutoScrollView.h"
#import "MyMoviePlayerViewController.h"
#import "SearchViewController.h"
#import "TitleTabBarView.h"
#import "CollectionView.h"
#import "TagListViewController.h"
@interface SelectAllViewController ()<UISearchBarDelegate>
@property (nonatomic, retain) NSMutableArray *alternatelyPlayArray;
@property (nonatomic, retain) UISearchBar *searchBar;


@end

@implementation SelectAllViewController
- (void)dealloc {

    [_alternatelyPlayArray release];
    [_searchBar release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.alternatelyPlayArray = [NSMutableArray array];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    显示当前播放
    TitleTabBarView *titleTBV = [TitleTabBarView shareInstanceWithFrame:CGRectMake(0, 0, 320, 46)];
    self.navigationItem.titleView = titleTBV;
    
    
    NSString *url = [NSString stringWithFormat:@"http://bapi.xinli001.com/fm/hot_tags.json/?flag=4&key=f6738336b525ad18efcad3ec8340d7ee&rows=3&offset=0"];
    [Network connectNetGetDataWithUrlString:url complement:^(id result) {
        for (NSDictionary *dic in [result objectForKey:@"data"]) {
            FMTitle *article = [[FMTitle alloc] init];
            [article setValuesForKeysWithDictionary:dic];
            [self.alternatelyPlayArray addObject:article];
        }

        NSMutableArray *imageArray = [NSMutableArray array];
        for (FMTitle *article in self.alternatelyPlayArray) {
            [imageArray addObject:article.cover];
        }
        AutoScrollView *view = [[AutoScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 150)];
        view.imageUrls = imageArray;
        [self.view addSubview:view];
        [view setTimeInterval:3];
        [view setTarget:self action:@selector(autoScrollViewAction:)];
        
    }];
//    搜索
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 214, 320, 40)];
    [self.view addSubview:self.searchBar];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入心情听FM"
    ;
    
//    场景/心情view
    NSString *sceneUrl = @"http://bapi.xinli001.com/fm/hot_tags.json/?flag=2&key=f6738336b525ad18efcad3ec8340d7ee&rows=9&offset=0";
    NSString *mindUrl = @"http://bapi.xinli001.com/fm/hot_tags.json/?flag=3&key=f6738336b525ad18efcad3ec8340d7ee&rows=9&offset=0";
    CollectionView *collectionView = [[CollectionView alloc] initWithFrame:CGRectMake(0, _searchBar.frame.origin.y + _searchBar.frame.size.height, self.view.frame.size.width, 254)];
    [Network connectNetGetDataWithUrlString:sceneUrl complement:^(id result) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < [[result objectForKey:@"data"] count] ; i++) {
            SceneModel *scene = [[SceneModel alloc] init];
            [scene setValuesForKeysWithDictionary:[[result objectForKey:@"data"] objectAtIndex:i]];
            [tempArray addObject:scene];

        }
        collectionView.sceneArray = tempArray;
        NSLog(@"%d", tempArray.count);
    }];
//    心情网络请求
    [Network connectNetGetDataWithUrlString:mindUrl complement:^(id result) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < [[result objectForKey:@"data"] count] ; i++) {
            SceneModel *scene = [[SceneModel alloc] init];
            [scene setValuesForKeysWithDictionary:[[result objectForKey:@"data"] objectAtIndex:i]];
            [tempArray addObject:scene];
        }
        collectionView.mindArray = tempArray;
    }];
    
    collectionView.frame = CGRectMake(0, 254, 320, self.view.frame.size.height - 254);
    [self.view addSubview:collectionView];
  [collectionView valueOfTag:^(NSString *tagName) {
      TagListViewController *tagListVC = [[TagListViewController alloc] init];
      tagListVC.name = tagName;
      [self.navigationController pushViewController:tagListVC animated:YES];
  }];
}
#pragma mark - searchBar 方法
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    self.searchBar.showsCancelButton = NO;
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    return YES;
    
}

- (void)autoScrollViewAction:(AutoScrollView *)view
{
    NSLog(@"%d", view.pageNo);
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
