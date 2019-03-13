//
//  AlternatelyPlayView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-1.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "AlternatelyPlayView.h"
#import "AlternatePlayViewCell.h"
#import "FMTitle.h"
@interface AlternatelyPlayView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *AlternatelyPlay;
@end
@implementation AlternatelyPlayView
-(void)dealloc
{
    [_AlternatelyPlay release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
        self.AlternatelyPlay = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) collectionViewLayout: layout];
        self.AlternatelyPlay.delegate = self;
        self.AlternatelyPlay.dataSource = self;
        self.AlternatelyPlay.pagingEnabled = YES;
        [self.AlternatelyPlay registerClass:[AlternatePlayViewCell class] forCellWithReuseIdentifier:@"reuse"];
        [self addSubview:self.AlternatelyPlay];
    }
    return self;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    AlternatePlayViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    FMTitle *article = [self.array objectAtIndex:indexPath.row];
    cell.cellData = (BaseModel *)article;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (void)setImageArray:(NSArray *)imageArray
{
    [super setImageArray:imageArray];
    self.array = imageArray;
    
    NSLog(@"------ %ld", self.imageArray.count);
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
