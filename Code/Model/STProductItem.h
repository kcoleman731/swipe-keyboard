//
//  STProductModel.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPrice.h"

extern NSString *const STProductListMIMEType;

@interface STProductItem : NSObject <NSCoding>

+ (instancetype)productWithData:(NSDictionary *)data;

- (id)objectForKey:(NSString *)key;

@property (nonatomic, strong) NSString *quatity;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *skuNumber;
@property (nonatomic, strong) STPrice *price;
@property (nonatomic, strong) NSString *name;

@end