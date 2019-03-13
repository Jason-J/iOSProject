//
//  InforConditionTypeViewController.h
//  ZGCOnline
//
//  Created by Lee on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InforConditionTypeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy)NSString *classID;
@property (nonatomic, copy)NSString *locationID;
@property (nonatomic, copy)NSNumber *provinceID;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *className;
@end
