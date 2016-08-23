//
//  STUtilities.m
//  
//
//  Created by Kevin Coleman on 8/19/16.
//
//

#import "STUtilities.h"

UIColor * STLightGrayColor()
{
    return [UIColor colorWithRed:229.0f/255.0f green:229.0f/255.0f blue:229.0f/255.0f alpha:1.0];
}

UIColor * STBlueColor()
{
    return [UIColor colorWithRed:118.0f/255.0f green:170.0f/255.0f blue:227.0f/255.0f alpha:1.0];
}

NSString *const STOrderNumberKey = @"STOrderNumberKey";
NSString *const STOrderPriceKey = @"STOrderPriceKey";
NSString *const STOrderItemKey = @"STOrderItemKey";

NSString *const STAddressName = @"STAddressName";
NSString *const STAddressStreet = @"STAddressStreet";
NSString *const STAddressCity = @"STAddressCity";
NSString *const STAddressLon = @"STAddressLon";
NSString *const STAddressLat = @"STAddressLat";

@implementation STUtilities

@end
