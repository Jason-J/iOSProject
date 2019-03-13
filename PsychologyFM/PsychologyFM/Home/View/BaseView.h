//
//  BaseView.h
//  PsychologyFM
//
//  Created by Jason on 14-7-30.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;
@interface BaseView : UIView
@property (nonatomic, retain) BaseModel *viewData;
@property (nonatomic, retain) NSArray *imageArray;
@end
