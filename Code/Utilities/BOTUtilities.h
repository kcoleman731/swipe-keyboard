//
//  STUtilities.h
//  
//
//  Created by Kevin Coleman on 8/19/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Returns the appropriate bundle that should be used for Nibs and Assets.
NSBundle * StaplesUIBundle();

// Light Gray
UIColor * BOTLightGrayColor();

// Staples Blue
UIColor * BOTBlueColor();

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
