//
//  STShipment.m
//  Pods
//
//  Created by Kevin Coleman on 8/24/16.
//
//

#import "BOTShipment.h"
                            
NSString *const BOTShipmentMIMEType = @"application/json+shipmentTrackingobject";

NSString *const BOTShipmentStatusKey = @"status";
NSString *const BOTShipmentDeliveryDataKey = @"deliveryDate";
NSString *const BOTShipmentNumberKey = @"shipmentNumber";
NSString *const BOTShipmentBoxesKey = @"boxes";
NSString *const BOTShipmentTypeKey = @"shipmentType";
NSString *const BOTShipmentOrderKey = @"order";
NSString *const BOTShipmentOrderNumberKey = @"orderNumber";
NSString *const BOTShipmentProductNameKey = @"productName";
NSString *const BOTShipmentProductURLKey = @"productImageUrl";

@implementation BOTShipment

+ (instancetype)shipmentWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _status = data[BOTShipmentStatusKey];
        _deliveryDate = data[BOTShipmentDeliveryDataKey];
        _number = data[BOTShipmentNumberKey];
        _boxCount = data[BOTShipmentBoxesKey];
        _type = data[BOTShipmentTypeKey];
        _heroProductName = data[BOTShipmentProductNameKey];
        _heroProductImageURL = data[BOTShipmentProductURLKey];
        
        BOTOrder *order = [BOTOrder new];
        order.orderNumber = data[BOTShipmentOrderNumberKey];
        _order = order;
    }
    return self;
}

@end
