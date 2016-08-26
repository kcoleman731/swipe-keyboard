//
//  STReward.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STReward.h"

NSString *const STRewardMIMEType = @"application/json+rewardobject";

NSString *const STRewardAmmountKey = @"amountRewards";
NSString *const STRewardLastUpdateKey = @"lastUpdate";
NSString *const STRewardEndsKey = @"rewardsEndDate";
NSString *const STRewardsMessageKey = @"rewardsMessage";
NSString *const STRewardsNumberKey = @"rewardsNumber";
NSString *const STRewardsPromoImageKey = @"rewardsPromoImage";
NSString *const STRewardsStartDateKey = @"rewardsStartDate";
NSString *const STRewardsTotalAmountKey = @"rewardsTotalAmount";
NSString *const STRewardsTypeKey = @"rewardsType";
NSString *const STRewardsUserNameKey = @"userName";

@implementation STReward

+ (instancetype)rewardWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.amount = data[STRewardAmmountKey];
        self.lastUpdate = data[STRewardLastUpdateKey];
        self.endDate = data[STRewardEndsKey];
        self.message = data[STRewardsMessageKey];
        self.number = data[STRewardsNumberKey];
        self.promoImageURL = data[STRewardsPromoImageKey];
        self.startDate = data[STRewardsStartDateKey];
        self.totalAmount = data[STRewardsTotalAmountKey];
        self.type = data[STRewardsTypeKey];
        self.userName = data[STRewardsUserNameKey];
    }
    return self;
}

@end
