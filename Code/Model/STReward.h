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

extern NSString *const STRewardMIMEType;
extern NSString *const STRewardTitleKey;
extern NSString *const STRewardNameKey;
extern NSString *const STRewardMemberTypeKey;
extern NSString *const STRewardAmmountKey;
extern NSString *const STRewardTypeKey;
extern NSString *const STRewardLinkKey;
extern NSString *const STRewardBarcodeLinkKey;
extern NSString *const STRewardBarcodeNumberKey;

typedef NS_ENUM(NSInteger, STRewardType) {
    STRewardTypeInkRecycling  = 0,
    STRewardTypeSummary  = 1,
    STRewardTypeYearToDateSpendDetails  = 2,
    STRewardTypeYearToDateSaveDetails  = 3,
};

@interface STReward : NSObject

@property (nonatomic) STRewardType *type;
@property (strong, nonatomic) NSString *imageURL;

// Ink Recycling Properties
@property (strong, nonatomic) NSString *inkCatridgesRecycled;
@property (strong, nonatomic) NSString *inkCatridgesRemaining;
@property (strong, nonatomic) NSString *inkRewardAmount;
@property (strong, nonatomic) NSString *inkRewardsEndDate;
@property (strong, nonatomic) NSString *inkRewardsMessage;
@property (strong, nonatomic) NSString *inkRewardsPromoImage;
@property (strong, nonatomic) NSString *inkRewardsStartDate;

// Summary
@property (strong, nonatomic) NSString *amountRewards;
@property (strong, nonatomic) NSString *rewardsEndDate;
@property (strong, nonatomic) NSString *rewardsMessage;
@property (strong, nonatomic) NSString *rewardsPromoImage;
@property (strong, nonatomic) NSString *rewardsStartDate;
@property (strong, nonatomic) NSString *rewardsTotalAmount;
@property (strong, nonatomic) NSString *rewardsNumber;
@property (strong, nonatomic) NSString *lastUpdate;

// Year to Date Spend
@property (strong, nonatomic) NSString *upgradeTier;
@property (strong, nonatomic) NSString *upgradeTierImageURL;
@property (strong, nonatomic) NSString *ytdBalanceAmount;
@property (strong, nonatomic) NSString *ytdMessage;
@property (strong, nonatomic) NSString *ytdSpendAmount;
@property (strong, nonatomic) NSString *ytdSpendEndDate;
@property (strong, nonatomic) NSString *ytdSpendStartDate;

// Year to Date Save
@property (strong, nonatomic) NSString *inkRewardsSavingAmount;
@property (strong, nonatomic) NSString *rewardsSavingAmount;
@property (strong, nonatomic) NSString *totalSavings;

// Old
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *memberType;
@property (strong, nonatomic) NSString *ammount;
@property (strong, nonatomic) NSString *rewardLink;
@property (strong, nonatomic) NSString *barcodeLink;
@property (strong, nonatomic) NSString *barcodeNumber;

+ (instancetype)rewardWithData:(NSDictionary *)data;

@end
