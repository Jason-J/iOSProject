//
//  SceneModel.h
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "BaseModel.h"

@interface SceneModel : BaseModel<NSCoding>
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *sceneId;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *_id;

//协议方法
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
@end
