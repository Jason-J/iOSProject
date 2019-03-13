//
//  PictureView.h
//  ZGCOnline
//
//  Created by Jason on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PageBlock)(NSInteger page, NSString *requestType);
typedef void(^ReturnBlock)(NSString *picId);

@interface PictureView : UIView
@property (nonatomic, retain) NSArray *aPagePictureList;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) NSString *requestType;

@property (nonatomic, copy) PageBlock pageBlock;
@property (nonatomic, copy) ReturnBlock picIdBlock;
- (void)valueWithPage:(PageBlock)page;
- (void)valueWithPicId:(ReturnBlock)PicId;

@end
