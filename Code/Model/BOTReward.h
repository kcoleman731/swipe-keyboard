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
extern NSString *const STRewardAmmountKey;
extern NSString *const STRewardLastUpdateKey;
extern NSString *const STRewardEndsKey;
extern NSString *const STRewardsMessageKey;
extern NSString *const STRewardsNumberKey;
extern NSString *const STRewardsPromoImageKey;
extern NSString *const STRewardsStartDateKey;
extern NSString *const STRewardsTotalAmountKey;
extern NSString *const STRewardsTypeKey;
extern NSString *const STRewardsUserNameKey;

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
