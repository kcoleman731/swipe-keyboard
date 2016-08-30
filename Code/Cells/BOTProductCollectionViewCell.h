//
//  STMultipleProductsCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProductItem.h"

//============================================================================
// Note: This cell is per old designs. Keeping around for now in case we reuse.
// Desing Link - https://t3.invisionapp.com/share/CD7XVFN7R#/screens/180458550
//=============================================================================

/**
 The `BOTItemCollectionViewCell` displays a product card in a conversation UI.
 */
@interface BOTProductCollectionViewCell : UICollectionViewCell

/**
 item Models the product that is displayed in the card.
 */
@property (readonly, nonatomic, strong) BOTProductItem *item;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeight;

/**
 Product Items Setter
 */
- (void)setProductItem:(BOTProductItem *)item;

@end
