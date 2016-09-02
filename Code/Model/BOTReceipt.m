//
//  BOTReceipt.m
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReceipt.h"
#import "BOTUtilities.h"

NSString *const BOTReceiptMIMEType = @"application/receiptObject";

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
        NSDictionary *parsedData = data[BOTMessagePartDataKey];
        NSDictionary *details = parsedData[BOTReceiptDetails];
        self.orderNumber = details[BOTReceiptOrderNumber];
        self.price = details[BOTReceiptPrice];
        self.eta = details[BOTReceiptEta];
        self.itemsCount = details[BOTReceiptItemsCount];
        self.address = [BOTAddress addressWithData:details[BOTReceiptAddress]];
    }
    return self;
}

@end
