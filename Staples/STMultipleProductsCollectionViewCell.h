//
//  STMultipleProductsCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProductItem.h"


@class STMultipleProductsCollectionViewCell;

@protocol STMultipleProductsCollectionViewCellDelegate

- (void)productCell:(STMultipleProductsCollectionViewCell *)cell addButtonWasPressedWithProduct:(STProductItem *)item;
- (void)productCell:(STMultipleProductsCollectionViewCell *)cell infoButtonWasPressedWithProduct:(STProductItem *)item;

@end

@interface STMultipleProductsCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) STProductItem *item;
@property (nonatomic, weak) id <STMultipleProductsCollectionViewCellDelegate> delegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(STProductItem *)item;

@end
