//
//  STReward.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>

// MIMEType
extern NSString *const BOTRewardMIMEType;

// Message Part Data Keys
extern NSString *const BOTRewardAmmountKey;
extern NSString *const BOTRewardLastUpdateKey;
extern NSString *const BOTRewardEndsKey;
extern NSString *const BOTRewardsMessageKey;
extern NSString *const BOTRewardsNumberKey;
extern NSString *const BOTRewardsPromoImageKey;
extern NSString *const BOTRewardsStartDateKey;
extern NSString *const BOTRewardsTotalAmountKey;
extern NSString *const BOTRewardsTypeKey;
extern NSString *const BOTRewardsUserNameKey;

@interface BOTReward : NSObject

@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) NSString *lastUpdate;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *promoImageURL;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *totalAmount;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *userName;

+ (instancetype)rewardWithData:(NSDictionary *)data;

@end
