//
//  BOTRepresentative.h
//  Staples
//
//  Created by Kevin Coleman on 8/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The MIMEType used for representative message parts.
 */
extern NSString *const BOTRepresentativeMIMEType;

@interface BOTRepresentative : NSObject

/**
 Returns an new `BOTRepresentative` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the customer service representative data.
 */
+ (instancetype)representativeWithData:(NSDictionary *)data;

@end
