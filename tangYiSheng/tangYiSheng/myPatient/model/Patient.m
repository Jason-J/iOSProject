//
//  Patient.m
//  tangYiSheng
//
//  Created by Jason on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "Patient.h"

@implementation Patient
- (void)dealloc
{
    [_nickName release];
    [_imageUrl release];
    [_gender release];
    [_birthday release];
    [_type release];
    [_diagnosedDate release];
    [super dealloc];
    
}

//
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return  nil;
}
@end
