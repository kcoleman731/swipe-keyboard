//
//  STReward.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STReward.h"

NSString *const STRewardMIMEType = @"application/json+rewardobject";

NSString *const STRewardTitleKey = @"STRewardTitleKey";
NSString *const STRewardNameKey = @"STRewardNameKey";
NSString *const STRewardMemberTypeKey = @"STRewardMemberTypeKey";
NSString *const STRewardAmmountKey = @"STRewardAmmountKey";
NSString *const STRewardTypeKey = @"STRewardTypeKey";
NSString *const STRewardLinkKey = @"STRewardLinkKey";
NSString *const STRewardBarcodeLinkKey = @"STRewardBarcodeLinkKey";
NSString *const STRewardBarcodeNumberKey = @"STRewardBarcodeNumberKey";

@implementation STReward

+ (instancetype)rewardWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.title = data[STRewardTitleKey];
        self.name = data[STRewardNameKey];
        self.memberType = data[STRewardMemberTypeKey];
        self.ammount = data[STRewardAmmountKey];
        //self.type = data[STRewardTypeKey];
        self.barcodeLink = data[STRewardBarcodeLinkKey];
        self.barcodeNumber = data[STRewardBarcodeNumberKey];
    }
    return self;
}

@end
