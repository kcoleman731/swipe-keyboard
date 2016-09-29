//
//  STProductModel.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTPrice.h"

/**
 The MIMEType representing a message containing product information.
 */
extern NSString *const BOTProductListMIMEType;

/**
 BOTProductItem is a convenience model used for parsing Product info from a BOT `LYRMessagePart` payload.
 */
@interface BOTProduct : NSObject <NSCoding>

/**
 Returns an new `BOTProductItem` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the product data.
 */
+ (instancetype)productWithData:(NSDictionary *)data;

/**
 Convenience method that returns the value of the supplied key.
 */
- (id)objectForKey:(NSString *)key;

/**
 Model Attributes
 */
@property (nonatomic, strong) NSString *quatity;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *skuNumber;
@property (nonatomic, strong) BOTPrice *price;
@property (nonatomic, strong) NSString *name;

@end