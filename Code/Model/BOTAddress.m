//
//  BOTAddress.m
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTAddress.h"
#import "BOTUtilities.h"

NSString *const BOTAddressMIMEType = @"application/addressobject";

NSString *const BOTAddressDetails = @"addressDetails";
NSString *const BOTAddressFirstName = @"firstName";
NSString *const BOTAddressLastName = @"lastName";
NSString *const BOTAddressStreet = @"street";
NSString *const BOTAddressCity = @"city";
NSString *const BOTAddressState = @"state";
NSString *const BOTAddressZip = @"zip";
NSString *const BOTAddressLat = @"lattitude";
NSString *const BOTAddressLon = @"longitude";

@implementation BOTAddress

+ (instancetype)addressWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        NSDictionary *parsedData = data[BOTMessagePartDataKey];
        if (parsedData) {
            NSDictionary *details = parsedData[BOTAddressDetails];
            [self hydrateAddress:details];
        } else {
            [self hydrateAddress:data];
        }
    }
    return self;
}

- (void)hydrateAddress:(NSDictionary *)data
{
    self.firstName = data[BOTAddressFirstName];
    self.lastName = data[BOTAddressLastName];
    self.street = data[BOTAddressStreet];
    self.city = data[BOTAddressCity];
    self.state = data[BOTAddressState];
    self.zip = data[BOTAddressZip];
    self.lattitude = [data[BOTAddressLat] floatValue];
    self.longitude = [data[BOTAddressLon] floatValue];
}

@end
