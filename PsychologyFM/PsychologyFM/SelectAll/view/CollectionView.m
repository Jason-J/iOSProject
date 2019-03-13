//
//  CollectionView.m
//  PsychologyFM
//
//  Created by Jason on 14-8-8.
//  Copyright (c) 2014年 l@yout.com 雷欧科技. All rights reserved.
//

#import "CollectionView.h"
#import "SceneModel.h"
#import "MyCollectionViewCell.h"
#import "CollectionTitleView.h"

@interface CollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionViewFlowLayout *layout;
@property (nonatomic, retain) UICollectionView *collectionView;
@end
@implementation CollectionView
-(void)dealloc
{
    [_collectionView release];
    [_layout release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.sceneArray = [NSMutableArray array];
        self.mindArray = [NSMutableArray array];
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        
        _layout.itemSize = CGSizeMake(90, 90);
        self.collectionView = [[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout] autorelease];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
        [_collectionView registerClass:[CollectionTitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuse1"];
    }
    return self;
}
- (void)setSceneArray:(NSMutableArray *)sceneArray
{
    if (_sceneArray != sceneArray) {
        [_sceneArray release];
        _sceneArray = [sceneArray retain];
        [self.collectionView reloadData];
    }
}
- (void)setMindArray:(NSMutableArray *)mindArray
{
    if (_mindArray != mindArray) {
        [_mindArray release];
        _mindArray = [mindArray retain];
        [self.collectionView reloadData];
    }
}
#pragma mark - titleView 的方法
//返回titleView 的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//返回titleView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize viewSize = CGSizeMake(300, 40);
    return viewSize;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuse1";
    CollectionTitleView *titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:str forIndexPath:indexPath];
    if (indexPath.section == 0) {
        titleView.titleLabel.text = @"场景";
    } else {
        titleView.titleLabel.text = @"心情";
    }
    return titleView;
}
#pragma mark - collection的方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuse";
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.cellData = [self.sceneArray objectAtIndex:indexPath.row];
    } else {
        cell.cellData = [self.mindArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);
    SceneModel *tag = nil;
    if (indexPath.section == 0) {
        tag = [self.sceneArray objectAtIndex:indexPath.row];
    } else {
        tag = [self.mindArray objectAtIndex:indexPath.row];
    }
    self.tagName(tag.name);
}
- (void)valueOfTag:(TAGRETURN)tagName
{
    self.tagName = tagName;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.sceneArray.count;
    } else {
        return self.mindArray.count;
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
