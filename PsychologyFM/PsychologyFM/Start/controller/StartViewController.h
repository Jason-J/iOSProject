//
//  StartViewController.h
//  PsychologyFM
//
//  Created by Jason on 14-7-29.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTitle.h"
@interface StartViewController : UIViewController

@property (nonatomic, retain)FMTitle *article;

+ (StartViewController *)shareInstance;

@end
