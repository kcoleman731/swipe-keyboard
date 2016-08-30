//
//  STPrice.m
//  Staples
//
//  Created by Kevin Coleman on 8/24/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTPrice.h"

NSString *const STPriceUnitOfMeasuerKey = @"unitOfMeasure";
NSString *const STPricePriceKey = @"price";
NSString *const STPriceFinalPriceKey = @"finalPrice";
NSString *const STPriceDisplayWasPricingKey = @"displayWasPricing";
NSString *const STPriceDisplayRegularPricingKey = @"displayRegularPricing";
NSString *const STPriceBuyMoreSaveMoreImageKey = @"buyMoreSaveMoreImage";

@implementation BOTPrice

+ (instancetype)priceWithData:(NSDictionary *)data;
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _unitOfMeasure = data[STPriceUnitOfMeasuerKey];
        _price = data[STPricePriceKey];
        _finalPrice = data[STPriceFinalPriceKey];
        _displayWasPricing = [data[STPriceDisplayWasPricingKey] boolValue];
        _displayRegularPricing = [data[STPriceDisplayRegularPricingKey] boolValue];
        _buyMoreSaveMoreImageURL = data[STPriceBuyMoreSaveMoreImageKey];
    }
    return self;
}

- (id)objectForKey:(NSString *)key
{
    if ([key isEqualToString:STPriceUnitOfMeasuerKey]) {
        return self.unitOfMeasure;
    } else if ([key isEqualToString:STPricePriceKey]) {
        return self.price;
    } else if ([key isEqualToString:STPriceFinalPriceKey]) {
        return self.finalPrice;
    } else if ([key isEqualToString:STPriceDisplayWasPricingKey]) {
        return @(self.displayWasPricing);
    } else if ([key isEqualToString:STPriceDisplayRegularPricingKey]) {
        return @(self.displayRegularPricing);
    } else if ([key isEqualToString:STPriceBuyMoreSaveMoreImageKey]) {
        return self.buyMoreSaveMoreImageURL;
    }
    return nil;
}

@end
