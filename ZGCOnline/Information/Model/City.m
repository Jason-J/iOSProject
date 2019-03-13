//
//  City.m
//  ZGCOnline
//
//  Created by Lee on 14-7-15.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "City.h"

@implementation City

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForKey:(NSString *)key
{
    return nil;
}

- (void)dealloc
{
    [_z_city_name release];
    [_z_location_id release];
    [_z_province_id release];
    [super dealloc];

}

@end
