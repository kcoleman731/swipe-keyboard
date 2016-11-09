//
//  BOTOrder.m
//  Staples
//
//  Created by Kevin Coleman on 9/1/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrder.h"
#import "BOTShipment.h"

NSString *const BOTOrderMIMEType = @"application/json+orderList";
NSString *const BOTReorderMIMEType = @"application/json+listreorder";
NSString *const BOTReturnMIMEType = @"application/json+listreturn";

// JSON Keys
NSString *const BOTOrderNumber = @"number";
NSString *const BOTOrderTotalPrice = @"totalPrice";
NSString *const BOTOrderETA = @"eta";
NSString *const BOTOrderItemsCount = @"itemsCount";
NSString *const BOTOrderDate = @"orderDate";
NSString *const BOTOrderItems = @"items";

@implementation BOTOrder

+ (instancetype)orderWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.orderNumber = data[BOTOrderNumber];
//        self.totalPrice = data[BOTOrderTotalPrice];
//        self.eta = data[BOTOrderETA];
//        self.orderDate = [NSDate dateWithTimeIntervalSince1970:[data[BOTOrderDate] integerValue]];
       
        NSArray *shipments = data[@"shipments"];
        if (shipments.count) {
            NSDictionary *shipment = shipments[0];
            NSArray *products = shipment[@"products"];
            
            NSMutableArray *items = [NSMutableArray new];
            for (NSDictionary *itemData in products) {
                BOTProduct *product = [BOTProduct productWithData:itemData];
                [items addObject:product];
            }
            self.items = items;
            self.itemsCount = [NSString stringWithFormat:@"%@", @(items.count)];
        }
    }
    return self;
}

@end
