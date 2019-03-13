//
//  Network.m
//  homework_网络抓包解析
//
//  Created by jason on 14-6-27.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "Network.h"

@interface Network ()

@end


@implementation Network
-(void)getDataWithUrlString:(NSString *)urlString complement:(BLOCK)block
{
    self.block = block;
    NSLog(@"%@", urlString);
    NSString *str = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod =  @"get";
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
             id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.block(object);
        }
    }];
    
}
+ (void)connectNetGetDataWithUrlString:(NSString *)urlString complement:(BLOCK)block
{
    Network *network = [[Network alloc] init];
    [network getDataWithUrlString:urlString complement:block];
    [network autorelease];
}
- (void)dealloc
{
    [super dealloc];
}

@end
