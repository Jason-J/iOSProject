//
//  SceneModel.m
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "SceneModel.h"

@implementation SceneModel
-(void)dealloc
{
    [_sort release];
    [_name release];
    [_cover release];
    [_sceneId release];
    [_flag release];
    [_title release];
    [_count release];
    [__id release];
    [super dealloc];
}
//归档协议方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sort forKey:@"sort"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.sceneId forKey:@"sceneId"];
    [aCoder encodeObject:self.flag forKey:@"flag"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_count forKey:@"count"];
    [aCoder encodeObject:__id forKey:@"_id"];
}
//解档协议方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setSort:[aDecoder decodeObjectForKey:@"sort"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setCover:[aDecoder decodeObjectForKey:@"cover"]];
        [self setSceneId:[aDecoder decodeObjectForKey:@"sceneId"]];
        [self setFlag:[aDecoder decodeObjectForKey:@"flag"]];
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setCount:[aDecoder decodeObjectForKey:@"count"]];
        [self set_id:[aDecoder decodeObjectForKey:@"_id"]];
    }
    return  self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.sceneId = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
