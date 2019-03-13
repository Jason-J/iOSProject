//
//  ShakeView.h
//  PsychologyFM
//
//  Created by Jason on 14-8-11.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TAGBLOCK)(NSString *tagName);
@interface ShakeView : UIView
@property (nonatomic, retain) NSMutableArray *selectedArray;
@property (nonatomic, copy) TAGBLOCK tagName;
- (void)valueOfTag:(TAGBLOCK)tagName;
@end
