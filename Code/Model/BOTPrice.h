//
//  STPrice.h
//  Staples
//
//  Created by Kevin Coleman on 8/24/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 BOTPrice is a convenience model used for parsing price info from a BOT `LYRMessagePart` payload.
 */
@interface BOTPrice : NSObject

/**
 Returns an new `BOTPrice` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the price data.
 */
+ (instancetype)priceWithData:(NSDictionary *)data;

/**
 Model Attirbutes
 */
@property (nonatomic) NSString *unitOfMeasure;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *finalPrice;
@property (nonatomic) BOOL displayWasPricing;
@property (nonatomic) BOOL displayRegularPricing;
@property (nonatomic) NSString *buyMoreSaveMoreImageURL;

@end
