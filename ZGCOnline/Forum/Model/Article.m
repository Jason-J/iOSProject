//
//  Article.m
//  ZGCOnline
//
//  Created by Jason on 14-7-9.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "Article.h"

@implementation Article

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
- (void)dealloc
{
    [_hits release];
    [_bookid release];
    [_nickname release];
    [_title release];
    [_boardid release];
    [_userid release];
    [_reply release];
    [super dealloc];
}
@end
