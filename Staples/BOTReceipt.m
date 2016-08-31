//
//  BOTReceipt.m
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReceipt.h"

NSString *const BOTReceiptMIMEType = @"";

@implementation BOTReceipt

+ (instancetype)receiptWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
