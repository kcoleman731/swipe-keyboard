//
//  STPrice.h
//  Staples
//
//  Created by Kevin Coleman on 8/24/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOTPrice : NSObject

+ (instancetype)priceWithData:(NSDictionary *)data;

@property (nonatomic) NSString *unitOfMeasure;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *finalPrice;
@property (nonatomic) BOOL displayWasPricing;
@property (nonatomic) BOOL displayRegularPricing;
@property (nonatomic) NSString *buyMoreSaveMoreImageURL;

@end
