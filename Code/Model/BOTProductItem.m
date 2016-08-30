//
//  STProductModel.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTProductItem.h"

NSString *const BOTProductListMIMEType = @"application/json+listobject";

NSString *const BOTProductQuantityKey = @"quantity";
NSString *const BOTProductImageURLKey = @"productImage";
NSString *const BOTProductSKUNumberKey = @"skuNo";
NSString *const BOTProductPriceKey = @"price";
NSString *const BOTProductNameKey = @"productName";

@implementation BOTProductItem

+ (instancetype)productWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data;
{
    self = [super init];
    if (self) {
        self.quatity = data[BOTProductQuantityKey];
        self.imageURL = data[BOTProductImageURLKey];
        self.skuNumber = data[BOTProductSKUNumberKey];
        self.price = [BOTPrice priceWithData:data[BOTProductPriceKey]];
        self.name = data[BOTProductNameKey];
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
