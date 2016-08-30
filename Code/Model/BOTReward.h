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

extern NSString *const BOTRewardMIMEType;

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
