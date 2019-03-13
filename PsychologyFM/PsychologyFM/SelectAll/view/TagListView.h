//
//  TagListView.h
//  PsychologyFM
//
//  Created by Jason on 14-8-11.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PAGEBLOCK)(NSInteger page);
@interface TagListView : UIView
@property (nonatomic, retain)NSMutableArray *tagListArray;
@property (nonatomic, copy) PAGEBLOCK pageBLOCK;

- (void)valueOfPage:(PAGEBLOCK) page;
@end
