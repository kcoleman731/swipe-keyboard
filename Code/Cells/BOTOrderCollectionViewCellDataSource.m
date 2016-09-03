//
//  BOTOrderCollectionViewCellDataSource.m
//  Staples
//
//  Created by Taylor Halliday on 9/2/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderCollectionViewCellDataSource.h"
#import "BOTOrderCollectionViewCellProductCollectionViewCell.h"

NSString *const BOTOrderCollectionViewCellDataSourceReuseIdentifier = @"BOTOrderCollectionViewCellDataSourceReuseIdentifier";

@interface BOTOrderCollectionViewCellDataSource ()

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <BOTProduct *> *items;

@end

@implementation BOTOrderCollectionViewCellDataSource

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier
{
    return BOTOrderCollectionViewCellDataSourceReuseIdentifier;
}

#pragma mark - Init / layout

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        [self registerOrderCell];
    }
    return self;
}

- (void)registerOrderCell
{
    [self.collectionView registerClass:[BOTOrderCollectionViewCellProductCollectionViewCell class] forCellWithReuseIdentifier:[BOTOrderCollectionViewCellProductCollectionViewCell reuseIdentifier]];
}

- (void)setOrder:(BOTOrder *)order
{
    if (_items != order.items) {
        _items = order.items;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOTOrderCollectionViewCellProductCollectionViewCell *cell = (BOTOrderCollectionViewCellProductCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate productWasTapped:cell.product];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOTOrderCollectionViewCellProductCollectionViewCell *cell = (BOTOrderCollectionViewCellProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[BOTOrderCollectionViewCellProductCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell setProduct:self.items[indexPath.row]];
    return cell;
}

@end
