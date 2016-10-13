//
//  STItemCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProduct.h"

/**
 The `BOTBackToSchoolViewCartButtonTappedNotification` is posed when a user taps the `View Cart` button that appears below a product card.
 */
extern NSString *const BOTBackToSchoolViewCartButtonTappedNotification;

/**
 The `BOTOrderStatusCollectionViewCell` displays an `BOT Card` with information about a single product.
 */
@interface BOTProductCollectionViewCell : UICollectionViewCell

/**
 item Models the product that is displayed in the card.
 */
@property (readonly, nonatomic, strong) BOTProduct *item;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 
 @param button Determines whether or not the cell should display an action button at the bottom of the cell.
 */
+ (CGFloat)cellHeightWithButton:(BOOL)button;

/**
 Product Item Setter
 */
- (void)setProductItem:(BOTProduct *)item showAddToCartButton:(BOOL)showAddToCartButton;

@end
