//
//  STRewardCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTRewardCollectionViewCell.h"
#import "BOTReward.h"
#import "BOTUtilities.h"
#import "ZXImage.h"
#import "ZXCode128Writer.h"

NSString *const BOTRewardCollectionViewCellTitle= @"Reward Cell";
NSString *const BOTRewardCollectionViewCellReuseIdentifier = @"BOTRewardCollectionViewCellReuseIdentifier";

@interface BOTRewardCollectionViewCell ()

@end

@implementation BOTRewardCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.view.layer.borderColor = BOTLightGrayColor().CGColor;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderWidth = 2;
    self.view.clipsToBounds = YES;
    
    [self.viewButton setTitle:@"View" forState:UIControlStateNormal];
    self.viewButton.hidden = YES;
}

+ (NSString *)reuseIdentifier
{
    return BOTRewardCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 240;
}

- (void)setReward:(BOTReward *)reward
{
    self.titleLabel.text = @"Staples Rewards";
    self.nameLabel.text = reward.userName;
    self.memberTypeLabel.text = @"Plus Member";
    self.ammountLabel.text = reward.amount;
    self.rewardTypeLabel.text = @"Redeemable";
    self.barcodeNumber.text = [NSString stringWithFormat:@"#%@",reward.number];
    [self setBarCode:reward.number];
    
    self.barcodeImage.layer.borderColor = [UIColor grayColor].CGColor;
    self.barcodeImage.layer.borderWidth = 2;
    self.barcodeImage.layer.cornerRadius = 4;
}

- (void) setBarCode:(NSString *)barCode
{
    if (barCode) {
        NSError *error = nil;
        ZXCode128Writer *writer = [ZXCode128Writer new];
        
        ZXBitMatrix *result = [writer encode:barCode
                                      format:kBarcodeFormatCode128
                                       width:self.frame.size.width
                                      height:self.frame.size.height
                                       error:&error];
        if (result) {
            CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
            self.barcodeImage.image = [UIImage imageWithCGImage:image];
        }
        else {
            NSLog(@"%@", error);
        }
    }
}

@end
