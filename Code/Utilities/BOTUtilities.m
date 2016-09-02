//
//  STUtilities.m
//  
//
//  Created by Kevin Coleman on 8/19/16.
//
//

#import "BOTUtilities.h"

NSBundle * StaplesUIBundle()
{
    // CocoaPods resource bundlep
    NSBundle *bundlePath = [NSBundle bundleWithIdentifier:@"org.cocoapods.staples-chat-ui"];
    NSString *path = [bundlePath pathForResource:@"StaplesResources" ofType:@"bundle"];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:path];
    if (resourcesBundle) {
        return resourcesBundle;
    }
    return [NSBundle mainBundle];
}

UIColor * BOTLightGrayColor()
{
    return [UIColor colorWithRed:229.0f/255.0f green:229.0f/255.0f blue:229.0f/255.0f alpha:1.0];
}

UIColor * BOTBlueColor()
{
    return [UIColor colorWithRed:0/255.0 green:104/255.0 blue:223/255.0 alpha:1.0];
}

NSDictionary *DataForMessagePart(LYRMessagePart *part)
{
    NSString *dataString = [[NSString alloc] initWithData:part.data encoding:NSUTF8StringEncoding];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return json;
}

// Flows
NSString *const BOTOptionTrackMyShipment = @"Track My Shipment";
NSString *const BOTOptionOrderNewSupplies = @"Order New Supplies";
NSString *const BOTOptionReorderLastShipment = @"Reorder Last Shipment";
NSString *const BOTOptionScanSchoolSuppliesList = @"Scan School Supplies List";
NSString *const BOTOptionReturnItems = @"Return Items";
NSString *const BOTOptionViewReceipt = @"View Receipt";
NSString *const BOTOptionViewMyRewards = @"View My Rewards";
NSString *const BOTOptionViewMyAddress = @"View My Address";
NSString *const BOTOptionCancelYourShipment = @"Cancel Your Shipment";
NSString *const BOTOptionViewCouponWallet = @"View Coupon Wallet";
NSString *const BOTOptionCheckGiftCardBalance = @"Check Giftcard Balance";

NSString *const BOTOptionPaper = @"Paper";
NSString *const BOTOptionRedSharpies = @"Red Sharpies";
NSString *const BOTOptionJournals = @"Journals";
NSString *const BOTOptionStaplers = @"Staplers";

NSString *const BOTMessagePartDataKey = @"data";

@implementation BOTUtilities

@end
