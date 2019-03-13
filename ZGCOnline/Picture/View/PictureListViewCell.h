//
//  PictureListViewCell.h
//  ZGCOnline
//
//  Created by Jason on 14-7-14.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureListViewCell : UICollectionViewCell
@property (nonatomic, retain) UIImageView *myImageView;

- (void)setImageWithImageUrlStr:(NSString *)string;
@end
