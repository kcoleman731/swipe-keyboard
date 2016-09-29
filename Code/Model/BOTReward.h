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

/**
 The MIMEType representing a message containing reward information.
 */
extern NSString *const BOTRewardMIMEType;

/**
 BOTReward is a convenience model used for parsing Reward info from a BOT `LYRMessagePart` payload.
 */
@interface BOTReward : NSObject

/**
 Returns an new `BOTReward` object hydratd with the supplied data.
 
 @param data An `NSDictionary` containing the reward data.
 */
+ (instancetype)rewardWithData:(NSDictionary *)data;

/**
 Model Attributes
 */
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
@property (strong, nonatomic) NSString *memberType;

@end
