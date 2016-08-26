//
//  STProductModel.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STProductItem.h"

NSString *const STProductListMIMEType = @"application/json+listobject";

NSString *const STProductQuantityKey = @"quantity";
NSString *const STProductImageURLKey = @"productImage";
NSString *const STProductSKUNumberKey = @"skuNo";
NSString *const STProductPriceKey = @"price";
NSString *const STProductNameKey = @"productName";

@implementation STProductItem

+ (instancetype)productWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data;
{
    self = [super init];
    if (self) {
        self.quatity = data[STProductQuantityKey];
        self.imageURL = data[STProductImageURLKey];
        self.skuNumber = data[STProductSKUNumberKey];
        self.price = [STPrice priceWithData:data[STProductPriceKey]];
        self.name = data[STProductNameKey];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.quatity = [aDecoder decodeObjectForKey:STProductQuantityKey];
        self.imageURL = [aDecoder decodeObjectForKey:STProductImageURLKey];
        self.skuNumber = [aDecoder decodeObjectForKey:STProductSKUNumberKey];
        self.price = [aDecoder decodeObjectForKey:STProductPriceKey];
        self.name = [aDecoder decodeObjectForKey:STProductNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.quatity forKey:STProductQuantityKey];
    [aCoder encodeObject:self.imageURL forKey:STProductImageURLKey];
    [aCoder encodeObject:self.skuNumber forKey:STProductSKUNumberKey];
    [aCoder encodeObject:self.price forKey:STProductPriceKey];
    [aCoder encodeObject:self.name forKey:STProductNameKey];
}

- (id)objectForKey:(NSString *)key
{
    if ([key isEqualToString:STProductPriceKey]) {
        return self.price;
    } else if ([key isEqualToString:STProductNameKey]) {
        return self.name;
    } else if ([key isEqualToString:STProductQuantityKey]) {
        return self.quatity;
    } else if ([key isEqualToString:STProductPriceKey]) {
        return self.price;
    } else if ([key isEqualToString:STProductImageURLKey]) {
        return self.imageURL;
    } else if ([key isEqualToString:STProductSKUNumberKey]) {
        return self.skuNumber;
    }
    return nil;
}

@end
