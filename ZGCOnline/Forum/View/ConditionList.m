//
//  ConditionList.m
//  ZGCOnline
//
//  Created by Jason on 14-7-8.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "ConditionList.h"
#import "Product.h"
#import "ListCell.h"
@interface ConditionList ()

@property (nonatomic, retain) UITableView *leftTableView;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, retain) NSArray *rightArray;
@end
@implementation ConditionList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.number = 0;
        self.rightArray = [self.tempArray objectAtIndex:self.number];
        self.leftTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 160, self.frame.size.height) style:UITableViewStylePlain] autorelease];
        self.rightTableView = [[[UITableView alloc] initWithFrame:CGRectMake(140, 64, 160, self.frame.size.height - 64) style:UITableViewStylePlain] autorelease];
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightTableView];
        self.leftTableView.dataSource = self;
        self.leftTableView.delegate = self;
        self.rightTableView.dataSource = self;
        self.rightTableView.delegate = self;
        [self.leftTableView registerClass:[ListCell class] forCellReuseIdentifier:@"reuse1"];
        [self.rightTableView registerClass:[ListCell class] forCellReuseIdentifier:@"reuse2"];
        
    }
    return self;
}
- (void)setLeftArray:(NSArray *)leftArray
{
    if (_leftArray != leftArray) {
        [_leftArray release];
        _leftArray = [leftArray retain];
        NSLog(@"%d", [self.leftArray count]);
        [self.leftTableView reloadData];
        
    }
}
- (void)setTempArray:(NSArray *)tempArray
{
    if (_tempArray != tempArray) {
        [_tempArray release];
        _tempArray = [tempArray retain];
        self.rightArray = [_tempArray objectAtIndex:self.number
                           ];
        [self.rightTableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = nil;
    if (tableView == self.leftTableView) {
        static NSString *str = @"reuse1";
        cell = [self.leftTableView dequeueReusableCellWithIdentifier:str];
        Product *product = [[Product alloc] init];
        [product setValuesForKeysWithDictionary:[self.leftArray objectAtIndex:indexPath.row]];
        cell.myLabel.text = product.name;
        [product release];
        return cell;
    }
    if (tableView == self.rightTableView) {
        static NSString *str = @"reuse2";
        cell = [self.rightTableView dequeueReusableCellWithIdentifier:str];
//        cell.myLabel.text = @"wew";
        Product *pro = [[Product alloc] init];
        [pro setValuesForKeysWithDictionary:[self.rightArray objectAtIndex:indexPath.row]];
        cell.myLabel.text = pro.name;
        cell.backgroundColor = [UIColor grayColor];
        cell.contentView.alpha = 0.5;
        return cell;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num = 100;
    if (tableView == self.leftTableView) {
        return num = [self.leftArray count];
    }
    if (tableView == self.rightTableView) {
        return num = [self.rightArray count];
    }
    return num;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        self.number = indexPath.row;
        self.rightArray = [self.tempArray objectAtIndex:self.number];

        [self.rightTableView reloadData];
    }
    if (tableView == self.rightTableView) {
        Product *pro = [[Product alloc] init];
        [pro setValuesForKeysWithDictionary:[self.rightArray objectAtIndex:indexPath.row]];

        self.block(pro.bid, pro.name);
        
        
    }
}

-(void)valueOfCateidOrBid:(LISTBLOCK)block
{
    self.block = block;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
