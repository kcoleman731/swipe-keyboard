//
//  STPrice.m
//  Staples
//
//  Created by Kevin Coleman on 8/24/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STPrice.h"

NSString *const STPriceUnitOfMeasuerKey = @"unitOfMeasure";
NSString *const STPricePriceKey = @"price";
NSString *const STPriceFinalPriceKey = @"finalPrice";
NSString *const STPriceDisplayWasPricingKey = @"displayWasPricing";
NSString *const STPriceDisplayRegularPricingKey = @"displayRegularPricing";
NSString *const STPriceBuyMoreSaveMoreImageKey = @"buyMoreSaveMoreImage";

@implementation STPrice

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

@end