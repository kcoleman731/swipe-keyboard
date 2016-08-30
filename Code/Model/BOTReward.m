//
//  STReward.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReward.h"

NSString *const BOTRewardMIMEType = @"application/json+rewardobject";

NSString *const BOTRewardAmmountKey = @"amountRewards";
NSString *const BOTRewardLastUpdateKey = @"lastUpdate";
NSString *const BOTRewardEndsKey = @"rewardsEndDate";
NSString *const BOTRewardsMessageKey = @"rewardsMessage";
NSString *const BOTRewardsNumberKey = @"rewardsNumber";
NSString *const BOTRewardsPromoImageKey = @"rewardsPromoImage";
NSString *const BOTRewardsStartDateKey = @"rewardsStartDate";
NSString *const BOTRewardsTotalAmountKey = @"rewardsTotalAmount";
NSString *const BOTRewardsTypeKey = @"rewardsType";
NSString *const BOTRewardsUserNameKey = @"userName";

@implementation BOTReward

+ (instancetype)rewardWithData:(NSDictionary *)data
{
    return [[self alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.amount = data[BOTRewardAmmountKey];
        self.lastUpdate = data[BOTRewardLastUpdateKey];
        self.endDate = data[BOTRewardEndsKey];
        self.message = data[BOTRewardsMessageKey];
        self.number = data[BOTRewardsNumberKey];
        self.promoImageURL = data[BOTRewardsPromoImageKey];
        self.startDate = data[BOTRewardsStartDateKey];
        self.totalAmount = data[BOTRewardsTotalAmountKey];
        self.type = data[BOTRewardsTypeKey];
        self.userName = data[BOTRewardsUserNameKey];
    }
    return self;
}

@end
