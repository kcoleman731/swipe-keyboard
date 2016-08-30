//
//  STUtilities.h
//  
//
//  Created by Kevin Coleman on 8/19/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSBundle * StaplesUIBundle();

UIColor * BOTLightGrayColor();

UIColor * BOTBlueColor();

/// Order Info
extern NSString *const BOTOrderNumberKey;
extern NSString *const BOTOrderPriceKey;
extern NSString *const BOTOrderItemKey;

// Address
extern NSString *const BOTAddressName;
extern NSString *const BOTAddressStreet;
extern NSString *const BOTAddressCity;
extern NSString *const BOTAddressLon;
extern NSString *const BOTAddressLat;

// Message Data Parsing

extern NSString *const BOTMessagePartDataKey;

@interface BOTUtilities : NSObject

@end
