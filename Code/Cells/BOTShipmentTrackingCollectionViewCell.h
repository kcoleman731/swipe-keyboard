//
//  BOTShipmentTrackingCollectionViewCell.h
//  Pods
//
//  Created by Jayashree on 19/08/16.
//
//

#import <UIKit/UIKit.h>
#import "BOTShipment.h"
#import "BOTCellContainerView.h"

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTShipmentTrackingCollectionViewCellReuseIdentifier;

/**
 The `BOTShipmentTrackingCollectionViewCell` displays an `BOT Card` with information about an order's shipment status.
 */
@interface BOTShipmentTrackingCollectionViewCell : UICollectionViewCell

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
- (void)setShipment:(BOTShipment *)shipment;

@end
