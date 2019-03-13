//
//  ConditionList.h
//  ZGCOnline
//
//  Created by Jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LISTBLOCK)(id result, NSString *name);
@interface ConditionList : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *leftArray;
//数组中嵌套数组的数组
@property (nonatomic, retain) NSArray *tempArray;

@property (nonatomic, copy) LISTBLOCK block;

-(void)valueOfCateidOrBid:(LISTBLOCK)block;
@end
