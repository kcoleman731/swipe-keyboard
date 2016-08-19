//
//  STMultipleProductsBaseCollectionViewCellDataSource.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProductItem.h"

#pragma mark - Temp Model

#pragma mark - Datasource Model

@protocol STMultipleProductsBaseCollectionViewCellDataSourceDelegate <NSObject>


@end

@interface STMultipleProductsBaseCollectionViewCellDataSource : NSObject <UICollectionViewDataSource>

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

// Setter for product data
- (void)setProducts:(NSArray<STProductItem *> *)items;

@end
