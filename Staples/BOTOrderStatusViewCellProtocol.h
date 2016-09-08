//
//  BOTOrderStatusViewCellProtocol.h
//  Staples
//
//  Created by Taylor Halliday on 9/8/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTShipment.h"

// Fwd Decl
@class BOTOrderStatusViewCell;

@protocol BOTOrderStatusViewCellDelegate <NSObject>

- (void)orderStatusCell:(BOTOrderStatusViewCell *)cell viewAllWasTappedWithShipment:(BOTShipment *)shipment;
- (void)orderStatusCell:(BOTOrderStatusViewCell *)cell trackShipmentWasTappedWithShipment:(BOTShipment *)shipment;
- (void)orderStatusCell:(BOTOrderStatusViewCell *)cell cellWasTappedWithShipment:(BOTShipment *)shipment;

@end
