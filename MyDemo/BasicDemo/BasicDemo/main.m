//
//  main.m
//  BasicDemo
//
//  Created by Jax on 2019/3/14.
//  Copyright © 2019 DX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_VALUE 32

#undef MAX_VALUE //取消定义MAX_VALUE
#define MAX_VALUE 44
typedef BOOL SEX;
typedef int CC;

@interface People : NSObject
{
    NSString *name;
    NSNumber *age;
    
}
@property (assign, nonatomic) SEX xingbie;
-(void)say;
@end


@implementation People
- (void)say{
//    NSLog(@"my name is %@,\n age is %@,\n sex is %d",name,age, self.xingbie);
}

-(instancetype)init{
    self = [super init];
    name = @"xx";
    age = @23;
    return self;
}
@end

@interface Man : People


@end
@interface Man  ()
@property (nonatomic, strong) NSString *sss;
@end

@implementation Man
-(void)say{
    NSLog(@"this man object");
}

@end

@interface NSString (MyStr)
+(NSString *)getCopyRightString;
@end
@implementation NSString (MyStr)

+(NSString *)getCopyRightString
{
    NSString *str = @"com";
    return str;
}

@end


@protocol PrintProtocolDelegate <NSObject>
-(void)processComplete;
@optional
-(void)mybeProcess;
@end



@interface PrintClass : NSObject{
    id delegate;
}

- (void)printDetals;
- (void)setDelegate:(id)newDelegate;

@end

@implementation PrintClass
-(void)printDetals
{
    NSLog(@"printing detals");
    [delegate processComplete];
}

-(void)setDelegate:(id)newDelegate
{
    delegate = newDelegate;
}

@end

@interface SampleClass : NSObject<PrintProtocolDelegate>
- (void)startAction;

@end
@implementation SampleClass

- (void)startAction{
    PrintClass *print = [[PrintClass alloc] init];
    [print setDelegate:self];
    [print printDetals];
}
-(void)processComplete
{
    NSLog(@"print complete");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!%d", MAX_VALUE);
        CC a = 232;
        
        People *p1 = [[People alloc] init];
        p1.xingbie = true;
        [p1 say];
        People *p2 = [[Man alloc] init];
        [p2 say];
        
        NSString *str = [NSString getCopyRightString];
        NSLog(@"%@",str);
        
        
        SampleClass *sap = [[SampleClass alloc] init];
        [sap startAction];
        
    }
    return 0;
}


