//
//  BOTAddress.h
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The MIMEType used for address message parts.
 */
extern NSString *const BOTAddressMIMEType;

@interface BOTAddress : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *lattitude;
@property (nonatomic, strong) NSString *longitude;

/**
 Returns an new `BOTAddress` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the address data.
 */
+ (instancetype)addressWithData:(NSDictionary *)data;

@end
