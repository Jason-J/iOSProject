//
//  ArticleListViewController.h
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListViewController : UIViewController

@property (nonatomic, retain) NSArray *articleList;
@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, copy) NSString *bbsid;
@property (nonatomic, copy) NSString *bid;
@end
