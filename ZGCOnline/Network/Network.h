//
//  Network.h
//  homework_网络抓包解析
//
//  Created by jason on 14-6-27.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BLOCK)(id result);

@interface Network : NSObject


@property (nonatomic, copy) BLOCK block;
@property (nonatomic, retain)NSString *ma;

- (void)getDataWithUrlString:(NSString *)urlString complement:(BLOCK)block;

+ (void)connectNetGetDataWithUrlString:(NSString *)urlString complement:(BLOCK)block;


@end
