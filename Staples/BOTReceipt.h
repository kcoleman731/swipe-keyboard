//
//  BOTReceipt.h
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The MIMEType used for receipt message parts.
 */
extern NSString *const BOTReceiptMIMEType;

@interface BOTReceipt : NSObject

/**
 Returns an new `BOTReceipt` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the receipt data.
 */
+ (instancetype)receiptWithData:(NSDictionary *)data;

@end
