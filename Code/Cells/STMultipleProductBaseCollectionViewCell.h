//
//  STMultipleProductsBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "STProductCollectionViewCell.h"
#import "STItemCollectionViewCell.h"
#import "STProductItem.h"

extern NSString *const STMultipleProductBaseCollectionViewCellTitle;

/**
 * Posted when a `Back To School` product card is selected. The `object` of the notification will be the cooresponing `Product` object.
 */
extern NSString *const BOTBackToSchoolItemSelectedNotification;

/**
 * Posted when a `Shipment` card is selected. The `object` of the notification will be the cooresponing `STShipment` object.
 */
extern NSString *const BOTShipmentSelectedNotification;

/**
 * Posted when a `Reward` card is selected. The `object` of the notification will be the cooresponing `STReward` object.
 */
extern NSString *const BOTRewardSelectedNotification;

/**
 * The `STMultipleProductBaseCollectionViewCell` displays a horizontally scrolling collection view used to display multiple `Bot Cards`within a single cell.
 */
@interface STMultipleProductBaseCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Cell Height
 */
+ (CGFloat)cellHeightForMessage:(LYRMessage *)message;

@end
