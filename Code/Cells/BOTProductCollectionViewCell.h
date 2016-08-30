//
//  STMultipleProductsCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProductItem.h"

@class BOTProductCollectionViewCell;

@protocol BOTSuggestedProductCollectionViewCellDelegate

- (void)productCell:(BOTProductCollectionViewCell *)cell addButtonWasPressedWithProduct:(BOTProductItem *)item;

- (void)productCell:(BOTProductCollectionViewCell *)cell infoButtonWasPressedWithProduct:(BOTProductItem *)item;

@end

@interface BOTProductCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) BOTProductItem *item;

@property (nonatomic, weak) id <BOTSuggestedProductCollectionViewCellDelegate> delegate;

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
- (void)setProductItem:(BOTProductItem *)item;

@end
