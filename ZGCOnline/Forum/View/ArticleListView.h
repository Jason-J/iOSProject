//
//  ArticleListView.h
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"

#import "SearchBarViewController.h"
#import "ArticleListViewController.h"

typedef void(^BOOKIDBLOCK)(NSString *bookid, NSString *boardid);
typedef void(^PageBLOCK)(NSInteger page, NSString *requestType);
typedef void(^SearchBlock)(NSString *search_text);


@interface ArticleListView : UIView <UIScrollViewDelegate, EGORefreshTableDelegate>
@property (nonatomic, copy) BOOKIDBLOCK block;

@property (nonatomic, copy) PageBLOCK pageBlock;
@property (nonatomic, copy) SearchBlock searchBlock;

- (void)valueOfBookidAndBoardid:(BOOKIDBLOCK)block;
- (void)valueOfPage:(PageBLOCK)page;
- (void)valueOfSearchText:(SearchBlock)searchText;
@property (nonatomic, retain) EGORefreshTableHeaderView *headerView;
@property (nonatomic, retain) EGORefreshTableFooterView *footerView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, retain) NSArray *aPageArticleList;
@property (nonatomic ,retain) NSMutableArray *articleList;
@property (nonatomic, assign) BOOL reloading;

@property (nonatomic, copy) NSString *requestType;

@property (nonatomic, retain) SearchBarViewController *searchBarVC;
@property (nonatomic, retain) NSArray *searchResurlArray;
- (id)initWithFrame:(CGRect)frame viewController:(ArticleListViewController*)viewController;
@end
