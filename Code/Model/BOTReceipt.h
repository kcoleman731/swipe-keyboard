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
 The MIMEType representing a message containing receipt information.
 */
extern NSString *const BOTReceiptMIMEType;

@interface BOTReceipt : NSObject

/**
 Returns an new `BOTReceipt` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the receipt data.
 */
+ (instancetype)receiptWithData:(NSDictionary *)data;

/**
 Model Attributes
 */
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *eta;
@property (nonatomic, strong) NSString *itemsCount;
@property (nonatomic, strong) BOTAddress *address;

@end
