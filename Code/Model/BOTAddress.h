//
//  BOTAddress.h
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The MIMEType representing a message containing address information.
 */
extern NSString *const BOTAddressMIMEType;

/**
 `BOTAddres` is a convenience model used for parsing address info from a BOT `LYRMessagePart` payload.
 */
@interface BOTAddress : NSObject

/**
 Returns an new `BOTAddress` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the address data.
 */
+ (instancetype)addressWithData:(NSDictionary *)data;

/**
 Model Attributes
 */
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic) NSUInteger lattitude;
@property (nonatomic) NSUInteger longitude;

@end
