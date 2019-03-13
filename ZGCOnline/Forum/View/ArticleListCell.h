//
//  ArticleListCell.h
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListCell : UITableViewCell

- (void)addCellWithArticleTitle:(NSString *)title author:(NSString *)author comment:(NSString *)comment hits:(NSString *)hits;
@end
