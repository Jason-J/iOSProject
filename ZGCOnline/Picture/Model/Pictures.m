//
//  Pictures.m
//  ZGCOnline
//
//  Created by Jason on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "Pictures.h"

@implementation Pictures
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"imgSrc"]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.imgSrc = [NSArray arrayWithObject:value];
        } else {
            self.imgSrc = value;
        }
        
    }
    if ([key isEqualToString:@"date"]) {
        NSLog(@"%@", value);
    }
    if ([key isEqualToString:@"id"]) {
        self.picId = value;
    }
//    if ([key isEqualToString:@"imgSrc"] && [value isKindOfClass:[NSString class]]) {
////        self.imgSrc = [NSArray arrayWithObject:value];
//
//    }
}
//- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
//    NSLog(@"%@",keyedValues);
//    
////    if ([key isEqualToString:@"id"]) {
//    if (keyedValues [@"id"]) {
//        self.picId = keyedValues[@"id"];
//        
//    }
//
////    }
//
//}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    
//}
-(void)dealloc
{
    [_picId release];
    [_title release];
    [_imgSrc release];
    [_num release];
    [_comNum release];
    [_url release];
    [_isProPic release];
    [_date release];
    [super dealloc];
}
@end
