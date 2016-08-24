//
//  STMultipleProductsCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProductItem.h"

@class STSuggestedProductCollectionViewCell;

@protocol STSuggestedProductCollectionViewCellDelegate

- (void)productCell:(STSuggestedProductCollectionViewCell *)cell addButtonWasPressedWithProduct:(STProductItem *)item;

- (void)productCell:(STSuggestedProductCollectionViewCell *)cell infoButtonWasPressedWithProduct:(STProductItem *)item;

@end

@interface STSuggestedProductCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) STProductItem *item;

@property (nonatomic, weak) id <STSuggestedProductCollectionViewCellDelegate> delegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(STProductItem *)item;

@end
