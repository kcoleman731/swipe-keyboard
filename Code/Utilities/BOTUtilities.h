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

// Flows
extern NSString *const BOTOptionTrackMyShipment;
extern NSString *const BOTOptionOrderNewSupplies;
extern NSString *const BOTOptionReorderLastShipment;
extern NSString *const BOTOptionScanSchoolSuppliesList;
extern NSString *const BOTOptionReturnItems;
extern NSString *const BOTOptionCancelYourShipment;
extern NSString *const BOTOptionViewCouponWallet;
extern NSString *const BOTOptionCheckGiftCardBalance;
extern NSString *const BOTOptionCheckGiftCardBalance;

extern NSString *const BOTOptionPaper;
extern NSString *const BOTOptionRedSharpies;
extern NSString *const BOTOptionJournals;
extern NSString *const BOTOptionStaplers;

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
