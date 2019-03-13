//
//  Pictures.h
//  ZGCOnline
//
//  Created by Jason on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pictures : NSObject

@property (nonatomic, copy) NSString *picId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) id imgSrc;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *comNum;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSNumber *isProPic;
@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *images_src;

@end
