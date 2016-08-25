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

@protocol STSuggestedProductCollectionViewCellDelegate

- (void)productCell:(STProductCollectionViewCell *)cell addButtonWasPressedWithProduct:(STProductItem *)item;

- (void)productCell:(STProductCollectionViewCell *)cell infoButtonWasPressedWithProduct:(STProductItem *)item;

@end

@interface STProductCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) STProductItem *item;

@property (nonatomic, weak) id <STSuggestedProductCollectionViewCellDelegate> delegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Cell Height
 */
+ (CGFloat)cellHeight;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(STProductItem *)item;

@end
