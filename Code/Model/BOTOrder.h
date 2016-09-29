//
//  BOTOrder.h
//  Staples
//
//  Created by Kevin Coleman on 9/1/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTProduct.h"

/**
 The MIMEType representing a message containing order information.
 */
extern NSString *const BOTOrderMIMEType;

/**
 The MIMEType representing a message containing reorder information.
 */
extern NSString *const BOTReorderMIMEType;

/**
 The MIMEType representing a message containing return order information.
 */
extern NSString *const BOTReturnMIMEType;

/**
 `BOTOrder` is a convenience model used for parsing order info from a BOT `LYRMessagePart` payload.
 */
@interface BOTOrder : NSObject


/**
 Returns an new `BOTOrder` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the order data.
 */
+ (instancetype)orderWithData:(NSDictionary *)data;


/**
 Model Attributes
 */
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *eta;
@property (nonatomic, strong) NSString *itemsCount;
@property (nonatomic, strong) NSDate *orderDate;
@property (nonatomic, strong) NSArray <BOTProduct *> *items;

@end
