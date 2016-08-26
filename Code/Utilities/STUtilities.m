//
//  STUtilities.m
//  
//
//  Created by Kevin Coleman on 8/19/16.
//
//

#import "STUtilities.h"

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

UIColor * STLightGrayColor()
{
    return [UIColor colorWithRed:229.0f/255.0f green:229.0f/255.0f blue:229.0f/255.0f alpha:1.0];
}

UIColor * STBlueColor()
{
    return [UIColor colorWithRed:0/255.0 green:104/255.0 blue:223/255.0 alpha:1.0];
}

NSString *const STOrderNumberKey = @"STOrderNumberKey";
NSString *const STOrderPriceKey = @"STOrderPriceKey";
NSString *const STOrderItemKey = @"STOrderItemKey";

NSString *const STAddressName = @"STAddressName";
NSString *const STAddressStreet = @"STAddressStreet";
NSString *const STAddressCity = @"STAddressCity";
NSString *const STAddressLon = @"STAddressLon";
NSString *const STAddressLat = @"STAddressLat";

NSString *const STMessagePartDataKey = @"data";

@implementation STUtilities

@end
