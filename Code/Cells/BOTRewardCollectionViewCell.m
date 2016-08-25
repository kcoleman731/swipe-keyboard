//
//  STRewardCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTRewardCollectionViewCell.h"
#import "STReward.h"
#import "STUtilities.h"
#import "ZXImage.h"
#import "ZXCode128Writer.h"

NSString *const BOTRewardCollectionViewCellTitle= @"Reward Cell";
NSString *const BOTRewardCollectionViewCellReuseIdentifier = @"BOTRewardCollectionViewCellReuseIdentifier";

@interface BOTRewardCollectionViewCell () <ATLMessagePresenting>

@end

@implementation BOTRewardCollectionViewCell

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
    return BOTRewardCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 280;
}

- (void)setReward:(STReward *)reward
{
    reward.title = @"Staples Rewards";
    reward.name = @"Kevin Coleman";
    reward.memberType = @"Plus Member";
    reward.ammount = @"$39.97";
    reward.barcodeNumber = @"3432970261";
    
    self.titleLabel.text = reward.title;
    self.nameLabel.text = reward.name;
    self.memberTypeLabel.text = reward.memberType;
    self.ammountLabel.text = reward.ammount;
    self.rewardTypeLabel.text = @"Redeemable";
    self.barcodeNumber.text = [NSString stringWithFormat:@"#%@",reward.barcodeNumber];
    [self setBarCode:reward.barcodeNumber];
    
    self.barcodeImage.layer.borderColor = [UIColor grayColor].CGColor;
    self.barcodeImage.layer.borderWidth = 2;
    self.barcodeImage.layer.cornerRadius = 4;
}

- (void) setBarCode:(NSString *)barCode {
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
