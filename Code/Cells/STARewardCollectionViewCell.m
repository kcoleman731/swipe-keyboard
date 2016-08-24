//
//  STRewardCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STARewardCollectionViewCell.h"
#import "STReward.h"
#import "STUtilities.h"

NSString *const STRewardCollectionViewCellTitle= @"Reward Cell";
NSString *const STRewardCollectionViewCellReuseIdentifier = @"STRewardCollectionViewCellReuseIdentifier";

@interface STARewardCollectionViewCell () <ATLMessagePresenting>

@end

@implementation STARewardCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.view.layer.borderColor = STLightGrayColor().CGColor;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderWidth = 2;
    self.view.clipsToBounds = YES;
    
    [self.viewButton setTitle:@"View" forState:UIControlStateNormal];
}

+ (NSString *)reuseIdentifier
{
    return STRewardCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 260;
}

NSString *const STMessagePartRewardListKey = @"rewardslistItems";

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        // Handle the error;
    }
    
    NSDictionary *data = json[STMessagePartDataKey];
    NSArray *rewardsJSON = data[STMessagePartDataKey];
    
    NSMutableArray *rewards = [[NSMutableArray alloc] init];
    for (NSDictionary *rewardJSON in rewardsJSON) {
        STReward *reward = [STReward rewardWithData:rewardJSON];
        [rewards addObject:reward];
    }
    
    STReward *reward = rewards[0];
    self.titleLabel.text = reward.title;
    self.nameLabel.text = reward.name;
    self.memberTypeLabel.text = reward.memberType;
    self.ammountLabel.text = reward.ammount;
    //self.rewardTypeLabel.text = reward.type;
    self.barcodeNumber.text = reward.barcodeNumber;
    
    self.barcodeImage.layer.borderColor = [UIColor grayColor].CGColor;
    self.barcodeImage.layer.borderWidth = 2;
    self.barcodeImage.layer.cornerRadius = 4;
}

- (void)updateWithSender:(id<ATLParticipant>)sender
{
    
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    
}

@end
