//
//  ConditionListViewController.h
//  ZGCOnline
//
//  Created by Jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionListViewController : UIViewController
@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, retain) NSArray *leftArray;
@property (nonatomic, retain) NSArray *tempArray;

@property (nonatomic, copy) NSString *bbsid;
@end
