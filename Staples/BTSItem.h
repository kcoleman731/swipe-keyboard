//
//  BTSItem.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTSItemPrice.h"

@interface BTSItem : NSObject

@property (nonatomic) NSUInteger quantity;
@property (nonatomic) NSURL *productImage;
@property (nonatomic) NSString *skuNumber;
@property (nonatomic) BTSItemPrice *price;
@property (nonatomic) NSString *productName;

@end
