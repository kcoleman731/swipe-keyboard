//
//  STProductModel.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTProduct.h"

NSString *const BOTProductListMIMEType = @"application/json+listobject";

NSString *const BOTProductQuantityKey = @"quantity";
NSString *const BOTProductImageURLKey = @"productImage";
NSString *const BOTProductSKUNumberKey = @"skuNo";
NSString *const BOTProductPriceKey = @"price";
NSString *const BOTProductNameKey = @"productName";

@implementation BOTProduct

+ (instancetype)productWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data;
{
    self = [super init];
    if (self) {

        self.quatity = data[BOTProductQuantityKey];
        if (!self.quatity) {
            self.quatity = data[@"orderedQuantity"];
        }
        
        self.imageURL = data[BOTProductImageURLKey];
        if (!self.imageURL) {
            self.imageURL = data[@"productImageUrl"];
        }
        
        self.skuNumber = data[BOTProductSKUNumberKey];
        if (!self.skuNumber) {
            self.skuNumber = data[@"sku"];
            if (!self.skuNumber) {
                self.skuNumber = data[@"skuNuber"];
            }
        }
        
        self.name = data[BOTProductNameKey];
        if (!self.name) {
            self.name = data[@"title"];
            if (!self.name) {
                self.name = data[@"productName"];
            }
        }
        
        id price = data[BOTProductPriceKey];
        if (price && [price isKindOfClass:[NSDictionary class]]) {
            self.price = [BOTPrice priceWithData:price];
        } else {
            self.price = [BOTPrice new];
            self.price.finalPrice = data[@"price"];
        }
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.quatity = [aDecoder decodeObjectForKey:BOTProductQuantityKey];
        self.imageURL = [aDecoder decodeObjectForKey:BOTProductImageURLKey];
        self.skuNumber = [aDecoder decodeObjectForKey:BOTProductSKUNumberKey];
        self.price = [aDecoder decodeObjectForKey:BOTProductPriceKey];
        self.name = [aDecoder decodeObjectForKey:BOTProductNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.quatity forKey:BOTProductQuantityKey];
    [aCoder encodeObject:self.imageURL forKey:BOTProductImageURLKey];
    [aCoder encodeObject:self.skuNumber forKey:BOTProductSKUNumberKey];
    [aCoder encodeObject:self.price forKey:BOTProductPriceKey];
    [aCoder encodeObject:self.name forKey:BOTProductNameKey];
}

- (id)objectForKey:(NSString *)key
{
    if ([key isEqualToString:BOTProductPriceKey]) {
        return self.price;
    } else if ([key isEqualToString:BOTProductNameKey]) {
        return self.name;
    } else if ([key isEqualToString:BOTProductQuantityKey]) {
        return self.quatity;
    } else if ([key isEqualToString:BOTProductPriceKey]) {
        return self.price;
    } else if ([key isEqualToString:BOTProductImageURLKey]) {
        return self.imageURL;
    } else if ([key isEqualToString:BOTProductSKUNumberKey]) {
        return self.skuNumber;
    }
    return nil;
}

@end
