//
//  BaseCollectionViewCell.h
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;
@interface BaseCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) BaseModel *cellData;
@end
