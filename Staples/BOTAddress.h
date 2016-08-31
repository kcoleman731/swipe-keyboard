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

/**
 Returns an new `BOTAddress` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the address data.
 */
+ (instancetype)addressWithData:(NSDictionary *)data;

@end
