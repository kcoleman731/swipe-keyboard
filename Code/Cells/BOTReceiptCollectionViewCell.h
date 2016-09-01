//
//  STShippingCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "BOTCellContainerView.h"
#import "BOTShipment.h"

extern NSString *const BOTShippingCollectionViewCellTitle;

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
