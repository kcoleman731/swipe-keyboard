//
//  BOTOrder.m
//  Staples
//
//  Created by Kevin Coleman on 9/1/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrder.h"

NSString *const BOTOrderMIMEType = @"application/list+order";
NSString *const BOTReorderMIMEType = @"application/list+reorder";
NSString *const BOTReturnMIMEType = @"application/list+return";

NSString *const BOTReorderItem = @"reorderItem";
NSString *const BOTOrderNumber = @"orderNumber";
NSString *const BOTOrderTotalPrice = @"totalPrice";
NSString *const BOTOrderETA = @"eta";
NSString *const BOTOrderItemsCount = @"itemsCount";
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
        self.totalPrice = data[BOTOrderTotalPrice];
        self.eta = data[BOTOrderETA ];
        self.itemsCount = data[BOTOrderItemsCount];
        
        // Parse products.
        NSArray *items = data[BOTOrderItems];
        NSMutableArray *products = [NSMutableArray new];
        for (NSDictionary *itemData in items) {
            BOTProduct *product = [BOTProduct productWithData:itemData];
            [products addObject:product];
        }
        self.items = products;
    }
    return self;
}

@end
