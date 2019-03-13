//
//  FMTitle.m
//  PsychologyFM
//
//  Created by Jason on 14-7-30.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "FMTitle.h"

@implementation FMTitle
-(void)dealloc
{
    [_url release];
    [_is_home release];
    [_cover release];
    [_titleId release];
    [_lizhi_url release];
    [_speaker_id release];
    [_background release];
    [_created release];
    [_favnum release];
    [_speak_url release];
    [_word release];
    [_speak release];
    [_commentnum release];
    [_title release];
    [_sharenum release];
    [_duration release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.titleId = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
@end
