//
//  SecondViewController.h
//  DelegateDemo
//
//  Created by Jax on 2019/3/14.
//  Copyright © 2019 大鑫哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol protocoDelegate <NSObject>

-(void)getSomeThing:(NSString *)string;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController
@property (weak, nonatomic) id<protocoDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
