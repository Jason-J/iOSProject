//
//  PictureView.m
//  ZGCOnline
//
//  Created by Jason on 14-7-11.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "PictureView.h"
#import "inforTableViewCell2.h"
#import "Pictures.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "HugePictureCell.h"

#import "MJRefresh.h"

@interface PictureView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *picArray;



@end
@implementation PictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.page = 1;
        self.picArray = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [self addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [_tableView release];
        [self setupRefresh];

    }
    return self;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Pictures *pic = [[Pictures alloc] init];
//    [pic setValuesForKeysWithDictionary:[self.picArray objectAtIndex:indexPath.row]];
    Pictures *pic = [self.picArray objectAtIndex:indexPath.row];
    if (pic.isProPic == [NSNumber numberWithInt:1]) {
        static NSString *str = @"reuse";
       inforTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[
                     [inforTableViewCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
        }
        NSRange range = {5,5};
        cell.MyLabel1.text = pic.title;
        cell.MyLabel3.text = [NSString stringWithFormat:@"%@图",pic.num];
        cell.MyLabel4.text = [NSString stringWithFormat:@"%@评论",pic.comNum];
        cell.MyLabel2.text = [pic.date substringWithRange:range];
        [cell.MyImageView1 setImageWithURL:[NSURL URLWithString:[pic.imgSrc objectAtIndex:0]]];
        [cell.MyIamgeView2 setImageWithURL:[NSURL URLWithString:[pic.imgSrc objectAtIndex:1]]];
        [cell.MyImageView3 setImageWithURL:[NSURL URLWithString:[pic.imgSrc objectAtIndex:2]]];
        return cell;
    } else {
        static NSString *str = @"reuse1";
        HugePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[HugePictureCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
        }
        cell.titleLabel.text = pic.title;
        NSRange range = {5,5};
        cell.dateLabel.text = [pic.date substringWithRange:range];
        if (pic.comNum == 0) {
            cell.comLabel.text = @"0评论";
        } else {
            cell.comLabel.text = [NSString stringWithFormat:@"%@评论",pic.comNum];
        }
        cell.picNumLabel.text = [NSString stringWithFormat:@"%@图", pic.num];
        [cell.myImageView setImageWithURL:[NSURL URLWithString:pic.imgSrc]];
        return cell;
    }
    


}
- (void)valueWithPage:(PageBlock)page
{
    self.pageBlock = page;
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.pageBlock(self.page, @"refresh");
    
    
    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView headerEndRefreshing];
//    });
}

- (void)footerRereshing
{
    self.pageBlock(self.page, @"getNextPage");
    
    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Pictures *pic = [[Pictures alloc] init];
//    [pic setValuesForKeysWithDictionary:[self.picArray objectAtIndex:indexPath.row]];
    Pictures *pic = [self.picArray objectAtIndex:indexPath.row];
    
    if (pic.isProPic == [NSNumber numberWithInt:1]) {
        return 130;
    }
    return 230;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---%d", self.picArray.count);
    return self.picArray.count;
}
- (void)valueWithPicId:(ReturnBlock)PicId
{
    self.picIdBlock = PicId;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Pictures *pic = [[Pictures alloc] init];
//    [pic setValuesForKeysWithDictionary:[self.picArray objectAtIndex:indexPath.row]];
    Pictures *pic = [self.picArray objectAtIndex:indexPath.row];
    self.picIdBlock(pic.picId);
}
- (void)setAPagePictureList:(NSArray *)aPagePictureList
{
    if (_aPagePictureList != aPagePictureList) {
        [_aPagePictureList release];
        _aPagePictureList = [aPagePictureList retain];
        if ([self.requestType isEqualToString:@"refresh"]) {
            [self.picArray removeAllObjects];
//            [self.picArray addObjectsFromArray:self.aPagePictureList];
            for (int i = 0; i < self.aPagePictureList.count; i++) {
                Pictures *pic = [[Pictures alloc] init];
                [pic setValuesForKeysWithDictionary:self.aPagePictureList[i]];
                [self.picArray addObject:pic];
                [pic release];
            }
            
            self.page = 1;
        } else if ([self.requestType isEqualToString:@"getNextPage"]) {
//            [self.picArray addObjectsFromArray:self.aPagePictureList];
            for (int i = 0; i < self.aPagePictureList.count; i++) {
                Pictures *pic = [[Pictures alloc] init];
                [pic setValuesForKeysWithDictionary:self.aPagePictureList[i]];
                [self.picArray addObject:pic];
                [pic release];
            }
            self.page ++;
        } else {
            self.page = 1;
//            [self.picArray addObjectsFromArray:self.aPagePictureList];
            for (NSDictionary *dic in self.aPagePictureList) {
                Pictures *pic = [[Pictures alloc] init];
                [pic setValuesForKeysWithDictionary:dic];
                [self.picArray addObject:pic];
                [pic release];
            }
            
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }
}
-(void)dealloc
{
    [_aPagePictureList release];
    [_picArray release];
    [_tableView release];
    [super dealloc];
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
