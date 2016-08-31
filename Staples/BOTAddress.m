//
//  BOTAddress.m
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTAddress.h"

NSString *const BOTAddressMIMEType = @"";

@implementation BOTAddress

+ (instancetype)addressWithData:(NSDictionary *)data
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
