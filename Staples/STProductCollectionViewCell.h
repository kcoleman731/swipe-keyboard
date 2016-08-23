//
//  STMultipleProductsCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProductItem.h"

@class STProductCollectionViewCell;

@protocol STProductCollectionViewCellDelegate

- (void)productCell:(STProductCollectionViewCell *)cell addButtonWasPressedWithProduct:(STProductItem *)item;

- (void)productCell:(STProductCollectionViewCell *)cell infoButtonWasPressedWithProduct:(STProductItem *)item;

@end

@interface STProductCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) STProductItem *item;

@property (nonatomic, weak) id <STProductCollectionViewCellDelegate> delegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(STProductItem *)item;

@end
