//
//  StartOrSuspendView.h
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMTitle.h"
@interface StartOrSuspendView : UIView


@property (nonatomic, retain) FMTitle *article;
+ (StartOrSuspendView *)shareInstanceWithFrame:(CGRect)frame;

- (void)circleTurn;//转
- (void)circlePase;//停

@end
