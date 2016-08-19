//
//  BTSItemPrice.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTSItemPrice : NSObject

@property (nonatomic) NSString *unitOfMeasure;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *finalPrice;
@property (nonatomic) BOOL displayWasPricing;
@property (nonatomic) BOOL displayRegularPricing;
@property (nonatomic) NSURL *buyMoreSaveMoreImage;

@end
