//
//  List.h
//  ZGCOnline
//
//  Created by Lee on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject

@property (nonatomic, copy)NSString *stitle;
@property (nonatomic, copy)NSString *sdate;
@property (nonatomic, retain)NSString *url;
@property (nonatomic, retain)NSString *imgsrc;
@property (nonatomic, copy)NSString *listID;
@property (nonatomic, retain)NSNumber *comment_num;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, retain)NSArray *pics;
@property (nonatomic, retain)NSNumber *pic_num;


@end
