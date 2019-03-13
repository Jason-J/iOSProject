//
//  RootOfForum.h
//  Zhongguancun
//
//  Created by jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(NSString *buttonStr);

@interface RootOfForum : UIView

@property (nonatomic, copy) ButtonBlock block;

- (void)valueWithBlock:(ButtonBlock ) block;


@end
