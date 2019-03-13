//
//  ArticleListView.m
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ArticleListView.h"
#import "ArticleListCell.h"

#import "Article.h"
#import "SearchBarViewController.h"

#define heightForCell 80.0
@interface ArticleListView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *search;
@property (nonatomic, retain) UISearchDisplayController *searchDisplay;

@end
@implementation ArticleListView


- (id)initWithFrame:(CGRect)frame viewController:(ArticleListViewController*)viewController
{
    self = [super initWithFrame:frame];
    if (self) {

        self.page = 1;
        self.articleList = [NSMutableArray array];
        self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.bounds.size.height - 64) style:UITableViewStylePlain] autorelease];
        [self addSubview:self.tableView];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        //        searchBar
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 10, 320, 40)];
        self.tableView.tableHeaderView = self.search ;
        self.search.delegate = self;
        [self.search setBarStyle:UIBarStyleDefault];
        self.search.placeholder = @"输入关键词";
        self.search.delegate = self;
        //        self.search.scopeButtonTitles = @[@"1", @"2", @"3"];??
        //        [search showsSearchResultsButton];
        //
        self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:self.search contentsController:viewController];
        self.searchDisplay.delegate = self;
        self.searchDisplay.searchResultsTableView.dataSource =  self;
        self.searchDisplay.searchResultsTableView.delegate = self;
        [self.searchDisplay.searchResultsTableView registerClass:[ArticleListCell class] forCellReuseIdentifier:@"reuse2"];
        //
        //
        //
        [self.search release];
        [self createHeaderView];
        
        [self testFinishedLoadDate];
        
        
        [self.tableView release];
        [self.tableView registerClass:[ArticleListCell class] forCellReuseIdentifier:@"reuse"];
        

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.page = 1;
//        self.articleList = [NSMutableArray array];
//        self.backgroundColor = [UIColor orangeColor];
//        self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.bounds.size.height - 64) style:UITableViewStylePlain] autorelease];
//        [self addSubview:self.tableView];
//        
//        self.tableView.dataSource = self;
//        self.tableView.delegate = self;
////        searchBar
//        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 10, 320, 40)];
//        self.tableView.tableHeaderView = self.search;
//        self.search.delegate = self;
//        [self.search setBarStyle:UIBarStyleDefault];
//        self.search.placeholder = @"输入关键词";
//        self.search.delegate = self;
////        self.search.scopeButtonTitles = @[@"1", @"2", @"3"];??
////        [search showsSearchResultsButton];
////
//        UISearchDisplayController *searchDispay = [[UISearchDisplayController alloc] initWithSearchBar:self.search contentsController:self.searchBarVC];
//        searchDispay.delegate = self;
////
////        
////        
//        [self.search release];
//        [self createHeaderView];
//        
//        [self testFinishedLoadDate];
//        
//
//        [self.tableView release];
//        [self.tableView registerClass:[ArticleListCell class] forCellReuseIdentifier:@"reuse"];
//
    }
    return self;
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"525252552");
    NSLog(@"%@", self.tableView.tableHeaderView);
    self.search.showsCancelButton = YES;
    return YES;
    
}
//查找
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"搜索");
    NSLog(@"%@", searchBar);
    NSLog(@"%@", searchBar.text);
    self.searchBlock(searchBar.text);
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.search resignFirstResponder];
}

- (void)valueOfSearchText:(SearchBlock)searchText
{
    self.searchBlock = searchText;
}
//上拉加载
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"tableVi  %f", self.tableView.contentOffset.y + 64);
    NSLog(@"offset y %f", self.tableView.contentOffset.y + self.tableView.frame.size.height);
    NSLog(@"yyyyyy y %f", 80.0 * self.articleList.count + 49);
    if (self.headerView)
	{
        NSLog(@"header");
        [self.headerView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (self.footerView)
	{
        [self.footerView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)setArticleList:(NSMutableArray *)articleList
{
    if (_articleList != articleList) {
        [_articleList release];
        _articleList = [articleList retain];
        [self.tableView reloadData];


    }
}
- (void)setAPageArticleList:(NSArray *)aPageArticleList
{
    if (_aPageArticleList != aPageArticleList) {
        [_aPageArticleList release];
        _aPageArticleList = [aPageArticleList retain];
        if ([self.requestType isEqualToString:@"refresh"]) {
            [self.articleList removeAllObjects];
            NSLog(@"count%d", [self.articleList count]);
            NSLog(@"%d", [self.aPageArticleList count]);
            [self.articleList addObjectsFromArray:self.aPageArticleList];
            NSLog(@" count 2   %d", [self.articleList count]);
            NSLog(@"刷新数据加载");
        } else if ([self.requestType isEqualToString:@"getNextPage"]) {
            [self.articleList addObjectsFromArray:self.aPageArticleList];
            self.page ++;
       
        } else {
            NSLog(@"!!!!!%d", [_aPageArticleList count]);
            [self.articleList addObjectsFromArray:_aPageArticleList];
            NSLog(@"######%d", [self.articleList count]);
        }
        NSLog(@"page === ===%d", self.page);
        [self.tableView reloadData];
        [self testFinishedLoadDate];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplay.searchResultsTableView) {
        NSString *str = @"reuse2";
        ArticleListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        Article *article = [[Article alloc] init];
        [article setValuesForKeysWithDictionary:[self.searchResurlArray objectAtIndex:indexPath.row]];
        [cell addCellWithArticleTitle:article.title author:article.nickname comment:article.reply hits:article.hits];
        return cell;
    } else {
    static NSString *str = @"reuse";
    ArticleListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    Article *article = [[Article alloc] init];
    [article setValuesForKeysWithDictionary:[self.articleList objectAtIndex:indexPath.row]];
    [cell addCellWithArticleTitle:article.title author:article.nickname comment:article.reply hits:article.hits];
    return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = [[Article alloc] init];
    if (tableView == self.searchDisplay.searchResultsTableView) {
        [article setValuesForKeysWithDictionary:[self.searchResurlArray objectAtIndex:indexPath.row]];
    } else {
        [article setValuesForKeysWithDictionary:[self.articleList objectAtIndex:indexPath.row]];
    }
    self.block(article.bookid, article.boardid);
    [article release];
}

-(void)valueOfBookidAndBoardid:(BOOKIDBLOCK)block
{
    self.block = block;
}
- (void)valueOfPage:(PageBLOCK)page
{
    self.pageBlock = page;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightForCell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplay.searchResultsTableView) {
        NSLog(@"%d", [self.searchResurlArray count]);
      return   [self.searchResurlArray count];
    } else {
        return [self.articleList count];
    }
}
- (void)setSearchResurlArray:(NSArray *)searchResurlArray
{
    if (_searchResurlArray != searchResurlArray) {
        [_searchResurlArray release];
        _searchResurlArray = [searchResurlArray retain];
        NSLog(@"--------%d", [searchResurlArray count]);
        [self.searchDisplay.searchResultsTableView reloadData];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - ego方法
-(void)testFinishedLoadDate
{
    [self finishReloadingData];
    [self setFooterView];
}
- (void)setFooterView
{
    CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    if (self.footerView && [self.footerView superview])
	{
        // reset position
        self.footerView.frame = CGRectMake(0.0f,
                                                       height,
                                                       self.tableView.frame.size.width,
                                                       self.bounds.size.height);
    }else
	{
        // create the footerView
        self.footerView = [[EGORefreshTableFooterView alloc] initWithFrame:
                                       CGRectMake(0.0f, height,
                                                  self.tableView.frame.size.width, self.bounds.size.height)];
        self.footerView.delegate = self;
        [self.tableView addSubview:self.footerView];
    }
    
    if (self.footerView)
	{
        [self.footerView refreshLastUpdatedDate];
    }
    
}
- (void)finishReloadingData
{
    _reloading = NO;
    
	if (self.headerView) {
        [self.headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    
    if (self.footerView) {
        [self.footerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        [self setFooterView];
        
    }
}

- (void)createHeaderView
{
    if (self.headerView && [self.headerView superview]) {
        [self.headerView removeFromSuperview];
    }
    self.headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height,self.frame.size.width, self.bounds.size.height)];
    [self.tableView addSubview:self.headerView];
    self.headerView.delegate = self;
    [self.headerView refreshLastUpdatedDate];
    [self.headerView release];
}
-(void)removeFooterView
{
    NSLog(@"%s", __func__);
    if (self.footerView && [self.footerView superview])
	{
        [self.footerView removeFromSuperview];
    }
    self.footerView = nil;
}
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	NSLog(@"%s", __func__);
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
	{
        // pull down to refresh data
        [self refreshView];
    }else if(aRefreshPos == EGORefreshFooter)
	{
        // pull up to load more data
        [self getNextPageView];
    }
	
	// overide, the actual loading data operation is done in the subclass
}
//刷新调用的方法
-(void)refreshView
{
    NSLog(@"%s", __func__);
	NSLog(@"刷新完成");
    self.pageBlock (self.page, @"refresh");
    [self testFinishedLoadDate];
	
}
//加载调用的方法
-(void)getNextPageView
{
    NSLog(@"加载");
    self.pageBlock(self.page, @"getNextPage");
	[self.tableView reloadData];
    [self removeFooterView];
    [self testFinishedLoadDate];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"%s", __func__);
	if (self.headerView)
	{
        [self.headerView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (self.footerView)
	{
        [self.footerView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    [self beginToReloadData:aRefreshPos];
}
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view
{
    return self.reloading;
}

@end
