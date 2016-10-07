//
//  STShipment.h
//  Pods
//
//  Created by Kevin Coleman on 8/24/16.
//
//

#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>
#import "BOTOrder.h"

/**
 The MIMEType representing a message containing shipment information.
 */
extern NSString *const BOTShipmentMIMEType;

/**
 BOTShipment is a convenience model used for parsing Shipment info from a BOT `LYRMessagePart` payload.
 */
@interface BOTShipment : NSObject

/**
 Returns an new `BOTShipment` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the shipment data.
 */
+ (instancetype)shipmentWithData:(NSDictionary *)data;

/**
 Shipment Attributes
 */
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *deliveryDate;
@property (nonatomic) NSString *number;
@property (nonatomic) NSString *boxCount;
@property (nonatomic) NSString *shipmentType;
@property (nonatomic) BOTOrder *order;
@property (nonatomic) NSString *heroProductName;
@property (nonatomic) NSString *heroProductImageURL;
@property (nonatomic) NSString *numberOfShipments;

@end
