//
//  STShipment.m
//  Pods
//
//  Created by Kevin Coleman on 8/24/16.
//
//

#import "STShipment.h"

NSString *const STShipmentMIMEType = @"application/json+shipmentTrackingobject";

NSString *const STShipmentStatusKey = @"status";
NSString *const STShipmentDeliveryDataKey = @"deliveryDate";
NSString *const STShipmentNumberKey = @"shipmentNumber";
NSString *const STShipmentBoxesKey = @"boxes";
NSString *const STShipmentTypeKey = @"shipmentType";
NSString *const STShipmentOrderNumberKey = @"orderNumber";

@implementation STShipment

+ (instancetype)shipmentWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _status = data[STShipmentStatusKey];
        _deliveryDate = data[STShipmentDeliveryDataKey];
        _number = data[STShipmentNumberKey];
        _boxCount = data[STShipmentBoxesKey];
        _type = data[STShipmentTypeKey];
        _orderNumber = data[STShipmentOrderNumberKey];
    }
    return self;
}

@end
