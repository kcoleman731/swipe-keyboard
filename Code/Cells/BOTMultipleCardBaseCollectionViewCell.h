//
//  STMultipleCardBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>

/**
 Posted when a `Back To School` View All button is selected. The `object` of the notification will be an array containing the BTS products.
 */
extern NSString *const BOTBackToSchoolViewAllSelectedNotification;

/**
 Posted when a `Back To School` product card is selected. The `object` of the notification will be the cooresponing `Product` object.
 */
extern NSString *const BOTBackToSchoolItemSelectedNotification;

/**
 Posted when a `Shipment` card is selected. The `object` of the notification will be the cooresponing `STShipment` object.
 */
extern NSString *const BOTShipmentSelectedNotification;

/**
 Posted when a `Reward` card is selected. The `object` of the notification will be the cooresponing `STReward` object.
 */
extern NSString *const BOTRewardSelectedNotification;
/**
 Posted when a `Add to cart` button is tapped from product cell. The `object` of the notification will be the corresponding `Product` object.
 */
extern NSString *const BOTAddToCartNotification;


/**
 The `STMultipleCardBaseCollectionViewCell` displays a horizontally scrolling collection view used to display multiple `Bot Cards` within a single cell.
 */
@interface BOTMultipleCardBaseCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

/**
 The items to display in the cards.
 */
@property (nonatomic, strong) NSArray *items;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeightForMessage:(LYRMessage *)message;

@end
