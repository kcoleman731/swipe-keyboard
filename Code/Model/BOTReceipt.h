//
//  BOTReceipt.h
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTAddress.h"

/**
 The MIMEType used for receipt message parts.
 */
extern NSString *const BOTReceiptMIMEType;

@interface BOTReceipt : NSObject

@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *eta;
@property (nonatomic, strong) NSString *itemsCount;
@property (nonatomic, strong) BOTAddress *address;

/**
 Returns an new `BOTReceipt` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the receipt data.
 */
+ (instancetype)receiptWithData:(NSDictionary *)data;

@end
