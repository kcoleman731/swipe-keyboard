//
//  BOTReceipt.m
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReceipt.h"

NSString *const BOTReceiptMIMEType = @"";

NSString *const BOTReceiptDetails = @"receiptDetails";
NSString *const BOTReceiptOrderNumber = @"orderNumber";
NSString *const BOTReceiptPrice = @"price";
NSString *const BOTReceiptEta = @"eta";
NSString *const BOTReceiptItemsCount = @"itemsCount";
NSString *const BOTReceiptAddress = @"address";

@implementation BOTReceipt

+ (instancetype)receiptWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.orderNumber = data[BOTReceiptOrderNumber];
        self.price = data[BOTReceiptOrderNumber];
        self.eta = data[BOTReceiptOrderNumber];
        self.itemsCount = data[BOTReceiptOrderNumber];
        self.address = [BOTAddress addressWithData:data[BOTReceiptOrderNumber]];
    }
    return self;
}

@end
