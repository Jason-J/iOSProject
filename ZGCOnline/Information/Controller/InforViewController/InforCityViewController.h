//
//  InforCityViewController.h
//  ZGCOnline
//
//  Created by Lee on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityBlock) (NSString *cityName, NSString *cityID, NSNumber *provinceID);

@interface InforCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, retain)NSNumber *provinceID;     // 传值
@property (nonatomic, retain)NSArray *provinceArray;
@property (nonatomic, retain)NSMutableArray *cityArray;
@property (nonatomic, copy)NSString *cityName;     // 传值
@property (nonatomic, copy)NSString *cityID;     // 传值

@property (nonatomic, copy)CityBlock block;

- (void)ValueCity:(CityBlock)block;

@end
