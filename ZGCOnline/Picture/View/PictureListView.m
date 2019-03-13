//
//  PictureListView.m
//  ZGCOnline
//
//  Created by Jason on 14-7-14.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "PictureListView.h"
#import "PictureListViewCell.h"
#import "Pictures.h"
@interface PictureListView () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) BOOL change;
@end

@implementation PictureListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.change = NO;
        self.backgroundColor = [UIColor blackColor];
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.itemSize = CGSizeMake(150, 100);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        self.collectionView = [[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 320, 336)   collectionViewLayout:self.flowLayout] autorelease];
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor blackColor
                                               ];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[PictureListViewCell class] forCellWithReuseIdentifier:@"reuse"];
        [self.flowLayout release];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 405, 300, 160)];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.contentSize = CGSizeMake(300, 500);
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 39)];
        [self.scrollView addSubview:self.contentLabel];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:16];
        self.contentLabel.textColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
    
    }
    return self;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    PictureListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    Pictures *pic = [self.picArray objectAtIndex:indexPath.row];
    [cell setImageWithImageUrlStr:pic.images_src];
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.picArray count];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.flowLayout.itemSize = CGSizeMake(310, 336);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.contentOffset = CGPointMake(320 * indexPath.item, 326);
    self.collectionView.pagingEnabled = YES;
    
}




-(void)setPicArray:(NSMutableArray *)picArray
{
    if (_picArray != picArray) {
        [_picArray release];
        _picArray = [picArray retain];
        NSLog(@"--- %d", [self.picArray count]);
        [self.collectionView reloadData];
    }
}
- (void)setContent:(NSString *)content
{
    if (_content != content) {
        [_content release];
        _content = [content retain];
    
        self.contentLabel.text = self.content;
        [self.contentLabel sizeToFit];
        self.scrollView.contentSize = CGSizeMake(300, self.contentLabel.frame.size.height);
    }
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
