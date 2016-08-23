//
//  STReward.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STReward.h"

NSString *const STRewardTitleKey = @"STRewardTitleKey";
NSString *const STRewardNameKey = @"STRewardNameKey";
NSString *const STRewardMemberTypeKey = @"STRewardMemberTypeKey";
NSString *const STRewardAmmountKey = @"STRewardAmmountKey";
NSString *const STRewardTypeKey = @"STRewardTypeKey";
NSString *const STRewardLinkKey = @"STRewardLinkKey";
NSString *const STRewardBarcodeLinkKey = @"STRewardBarcodeLinkKey";
NSString *const STRewardBarcodeNumberKey = @"STRewardBarcodeNumberKey";

@implementation STReward

+ (instancetype)rewardWithMessage:(LYRMessage *)message
{
    return [[self alloc] initWithMessage:message];
}

- (id)initWithMessage:(LYRMessage *)message
{
    self = [super init];
    if (self) {
        LYRMessagePart *part = message.parts[0];
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:nil];
        self.title = data[STRewardTitleKey];
        self.name = data[STRewardNameKey];
        self.memberType = data[STRewardMemberTypeKey];
        self.ammount = data[STRewardAmmountKey];
        self.type = data[STRewardTypeKey];
        self.barcodeLink = data[STRewardBarcodeLinkKey];
        self.barcodeNumber = data[STRewardBarcodeNumberKey];
    }
    return self;
}

@end
