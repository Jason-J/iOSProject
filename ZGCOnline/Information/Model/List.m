//
//  List.m
//  ZGCOnline
//
//  Created by Lee on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "List.h"

@implementation List

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.listID = value;
    }
    if ([key isEqualToString:@"title"]) {
        self.stitle = value;
    }
    

}

- (id)valueForKey:(NSString *)key
{
    return nil;
}

- (void)dealloc
{
    [_stitle release];
    [_listID release];
    [_sdate release];
    [_imgsrc release];
    [_url release];
    [_comment_num release];
    [_type release];
    [_pics release];
    [_pic_num release];
    [super dealloc];
}
@end
