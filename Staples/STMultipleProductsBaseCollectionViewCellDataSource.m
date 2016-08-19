//
//  STMultipleProductsBaseCollectionViewCellDataSource.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleProductsBaseCollectionViewCellDataSource.h"

#import "STMultipleProductsCollectionViewCell.h"

@interface STMultipleProductsBaseCollectionViewCellDataSource ()

@property (nonatomic, strong) NSString *cellReuseIdentifier;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<STProductItem *> *productItems;

@end

@implementation STMultipleProductsBaseCollectionViewCellDataSource

#pragma mark - Init / Common Init

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    // Register Cell
    [self registerCell];
}

- (void)registerCell
{
    UINib *collectionNib = [UINib nibWithNibName:@"STMultipleProductsCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:collectionNib forCellWithReuseIdentifier:STMultipleProductsCollectionViewCellId];
}

#pragma mark - Setter for data

- (void)setProducts:(NSArray<STProductItem *> *)items
{
    self.productItems = items;
    [[self collectionView] reloadData];
}

#pragma mark - Collection View Datasource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STMultipleProductsCollectionViewCellId forIndexPath:indexPath];
    
    // customize
    return cell;
}



@end
