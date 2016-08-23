//
//  STMultipleProductsBaseCollectionViewCellDataSource.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleProductsBaseCollectionViewCellDataSource.h"



@interface STMultipleProductsBaseCollectionViewCellDataSource ()

@property (nonatomic, strong) NSString *cellReuseIdentifier;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) id <STProductCollectionViewCellDelegate> cellDelegate;
@property (nonatomic, strong) NSArray<STProductItem *> *productItems;

@end

@implementation STMultipleProductsBaseCollectionViewCellDataSource

#pragma mark - Init / Common Init

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                          cellDelegate:(id <STProductCollectionViewCellDelegate>)delgate
{
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        self.cellDelegate = delgate;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
//     Register Cell
    [self registerCell];
}

- (void)registerCell
{
    UINib *collectionNib = [UINib nibWithNibName:@"STMultipleProductsCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:collectionNib forCellWithReuseIdentifier:[STProductCollectionViewCell reuseIdentifier]];
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
    STProductCollectionViewCell *cell = (STProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[STProductCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    STProductItem *item = self.productItems[indexPath.row];
    [cell setProductItem:item];
    cell.delegate = self.cellDelegate;
    
    return cell;
}

@end
