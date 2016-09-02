//
//  BOTOrder.h
//  Staples
//
//  Created by Kevin Coleman on 9/1/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTProduct.h"

extern NSString *const BOTOrderMIMEType;

@interface BOTOrder : NSObject

@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *eta;
@property (nonatomic, strong) NSString *itemsCount;
@property (nonatomic, strong) NSArray <BOTProduct *> *items;

+ (instancetype)orderWithData:(NSDictionary *)data;

@end
