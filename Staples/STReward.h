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

extern NSString *const STRewardTitleKey;
extern NSString *const STRewardNameKey;
extern NSString *const STRewardMemberTypeKey;
extern NSString *const STRewardAmmountKey;
extern NSString *const STRewardTypeKey;
extern NSString *const STRewardLinkKey;
extern NSString *const STRewardBarcodeLinkKey;
extern NSString *const STRewardBarcodeNumberKey;

@interface STReward : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *memberType;
@property (strong, nonatomic) NSString *ammount;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *rewardLink;
@property (strong, nonatomic) NSString *barcodeLink;
@property (strong, nonatomic) NSString *barcodeNumber;

+ (instancetype)rewardWithMessage:(LYRMessage *)message;

@end
