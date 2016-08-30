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


NSString *const BOTAddressName = @"STAddressName";
NSString *const BOTAddressStreet = @"STAddressStreet";
NSString *const BOTAddressCity = @"STAddressCity";
NSString *const BOTAddressLon = @"STAddressLon";
NSString *const BOTAddressLat = @"STAddressLat";

NSString *const BOTMessagePartDataKey = @"data";

@implementation BOTUtilities

@end
