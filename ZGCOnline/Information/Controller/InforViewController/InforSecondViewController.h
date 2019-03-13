//
//  InforSecondViewController.h
//  ZGCOnline
//
//  Created by Lee on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLOCK1) (NSMutableArray *array);

@interface InforSecondViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain)NSMutableArray *didCollectionArray;
@property (nonatomic, retain)NSMutableArray *moreCollectionArray;


@property (nonatomic, copy)BLOCK1 block;

- (void)valueArray:(BLOCK1) block;



@end
