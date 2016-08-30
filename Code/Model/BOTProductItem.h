//
//  STProductModel.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTPrice.h"

extern NSString *const BOTProductListMIMEType;

@interface BOTProductItem : NSObject <NSCoding>

+ (instancetype)productWithData:(NSDictionary *)data;

- (id)objectForKey:(NSString *)key;

@property (nonatomic, strong) NSString *quatity;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *skuNumber;
@property (nonatomic, strong) BOTPrice *price;
@property (nonatomic, strong) NSString *name;

@end