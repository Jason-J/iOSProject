//
//  CollectionView.h
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TAGRETURN)(NSString *tagName);
@interface CollectionView : UIView
@property (nonatomic, retain) NSMutableArray *sceneArray;
@property (nonatomic, retain) NSMutableArray *mindArray;

@property (nonatomic, copy) TAGRETURN tagName;
-(void)valueOfTag:(TAGRETURN) tagName;

@end
