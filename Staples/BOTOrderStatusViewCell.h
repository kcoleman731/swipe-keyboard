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

// Fwd Decl
@class BOTOrderStatusViewCell;

@protocol BOTOrderStatusViewCellDelegate <NSObject>

- (void)orderStatusCell:(BOTOrderStatusViewCell *)cell viewAllWasTappedWithShipment:(BOTShipment *)shipment;
- (void)orderStatusCell:(BOTOrderStatusViewCell *)cell trackShipmentWasTappedWithShipment:(BOTShipment *)shipment;
- (void)orderStatusCell:(BOTOrderStatusViewCell *)cell cellWasTappedWithShipment:(BOTShipment *)shipment;

@end

@interface BOTOrderStatusViewCell : UICollectionViewCell

@property (nonatomic, weak) id <BOTOrderStatusViewCellDelegate> delegate;
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
