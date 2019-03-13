//
//  TagListView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-11.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "TagListView.h"
#import "HomeCell.h"
#import "MJRefresh.h"
#import "FMTitle.h"
#import "StartOrSuspendView.h"
#import "MyMoviePlayerViewController.h"
#import "MusicDetailViewController.h"
#import "TitleTabBarView.h"
@interface TagListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@end
@implementation TagListView
- (void)dealloc
{
    [_tableView release];
    [_tagListArray release];
    Block_release(_pageBLOCK);
    [super dealloc];
}
-(void)valueOfPage:(PAGEBLOCK)page
{
    self.pageBLOCK = page;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.page = 0;
        _tableView = [[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain] autorelease];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"reuse"];
    }
    [self setupRefresh];
    return self;
}
- (void)setTagListArray:(NSMutableArray *)tagListArray
{
    if (_tagListArray != tagListArray) {
        [_tagListArray release];
        _tagListArray = [tagListArray retain];
    }
    [_tableView reloadData];
    [_tableView footerEndRefreshing];

}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    self.page += 10;
    self.pageBLOCK(self.page);
}

#pragma mark - tableView方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.cellData = [self.tagListArray objectAtIndex:indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagListArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMTitle *article = [self.tagListArray objectAtIndex:indexPath.row];
    TitleTabBarView *titleTBV = [TitleTabBarView shareInstanceWithFrame:CGRectMake(0, 0, 320, 46)];
    titleTBV.viewData = (BaseModel *)article;

    StartOrSuspendView *view = [StartOrSuspendView shareInstanceWithFrame:CGRectZero];
    view.article = article;
    //播放器
    MyMoviePlayerViewController *player = [MyMoviePlayerViewController     shareInstance];
    
    MusicDetailViewController *musicDetailVC = [MusicDetailViewController shareInstance];
    musicDetailVC.article = article;
    if ([player isStart]) {
        [player.moviePlayer stop];
        [view circlePase];
        player.article = article ;
        [player.moviePlayer play];
        [view circleTurn];
    } else {
        player.article = article;
        [player.moviePlayer play];
        //        [view circlePase];
        [view circleTurn];
    }
//    [self presentViewController:musicDetailVC animated:YES completion:^{
//        
//    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
