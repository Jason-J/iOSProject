//
//  MusicDetailViewController.h
//  PsychologyFM
//
//  Created by Jason on 14-8-5.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTitle.h"
@interface MusicDetailViewController : UIViewController
@property (nonatomic, retain)FMTitle *article;
@property (nonatomic, assign) double duration;
@property (nonatomic, retain) NSMutableArray *FMListArray;
@property (nonatomic, assign) NSInteger currentPlay;
+ (MusicDetailViewController *)shareInstance;
@end
