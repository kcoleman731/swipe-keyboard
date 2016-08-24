//
//  STUtilities.h
//  
//
//  Created by Kevin Coleman on 8/19/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIColor * STLightGrayColor();

UIColor * STBlueColor();

/// Order Info
extern NSString *const STOrderNumberKey;
extern NSString *const STOrderPriceKey;
extern NSString *const STOrderItemKey;

// Address
extern NSString *const STAddressName;
extern NSString *const STAddressStreet;
extern NSString *const STAddressCity;
extern NSString *const STAddressLon;
extern NSString *const STAddressLat;

// Message Data Parsing

extern NSString *const STMessagePartDataKey;

@interface STUtilities : NSObject

@end
