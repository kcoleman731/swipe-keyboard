//
//  STShippingCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "BOTShipment.h"

extern NSString *const BOTShippingCollectionViewCellTitle;

/**
 The `BOTReceiptCollectionViewCell` displays an `BOT Card` with information about a Staples customer receipt.
 */
@interface BOTReceiptCollectionViewCell : UICollectionViewCell

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeight;

@end
