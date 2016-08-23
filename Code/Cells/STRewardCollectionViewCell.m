//
//  STRewardCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STRewardCollectionViewCell.h"
#import "STReward.h"
#import "STUtilities.h"

NSString *const STRewardCollectionViewCellTitle= @"Reward Cell";
NSString *const STRewardCollectionViewCellMimeType = @"json/reward";
NSString *const STRewardCollectionViewCellReuseIdentifier = @"STRewardCollectionViewCellReuseIdentifier";

@interface STRewardCollectionViewCell () <ATLMessagePresenting>

@end

@implementation STRewardCollectionViewCell

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

- (void)presentMessage:(LYRMessage *)message
{
    STReward *reward = [STReward rewardWithMessage:message];
    self.titleLabel.text = reward.title;
    self.nameLabel.text = reward.name;
    self.memberTypeLabel.text = reward.memberType;
    self.ammountLabel.text = reward.ammount;
    self.rewardTypeLabel.text = reward.type;
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
