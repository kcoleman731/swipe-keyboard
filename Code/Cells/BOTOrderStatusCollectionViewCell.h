//
//  BOTOrderStatusViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTShipment.h"

/**
 Posted when the `Track Shipment` button is tapped.
 */
extern NSString *const BOTTrackOrderShipmentButtonTapNotification;

/**
 Posted when the `View All` button is tapped.
 */
extern NSString *const BOTViewAllOrdersButtonTapNotification;

/**
 The title of the cell. Used for testing purposes.
 */
extern NSString *const BOTOrderStatusCollectionViewCellTitle;

/**
 The MIMEType used for message parts that should display the cell.
 */
extern NSString *const BOTOrderStatusCollectionViewCellMimeType;

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTOrderStatusCollectionViewCellReuseIdentifier;

@interface BOTOrderStatusCollectionViewCell : UICollectionViewCell

/**
 The shipment for the cell.
 */
@property (nonatomic, strong) BOTShipment *shipment;

/**
 Cell height
 */
+ (CGFloat)cellHeight;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

@end
