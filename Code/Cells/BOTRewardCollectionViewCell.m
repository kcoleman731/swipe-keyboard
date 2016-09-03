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

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *memberTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ammountLabel;
@property (strong, nonatomic) IBOutlet UILabel *rewardTypeLabel;
@property (strong, nonatomic) IBOutlet UIButton *viewButton;
@property (strong, nonatomic) IBOutlet UIImageView *barcodeImage;
@property (strong, nonatomic) IBOutlet UILabel *barcodeNumber;

@end

@implementation BOTRewardCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.view.layer.cornerRadius = 4.0f;
    self.view.layer.masksToBounds = NO;
    self.view.layer.borderWidth = 1.0f;
    self.view.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.view.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 3;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.view.userInteractionEnabled = NO;
    
    [self.viewButton setTitle:@"View" forState:UIControlStateNormal];
    self.viewButton.hidden = YES;
}

+ (NSString *)reuseIdentifier
{
    return BOTRewardCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 224;
}

- (void)setReward:(BOTReward *)reward
{
    self.titleLabel.text = @"Staples Rewards";
    self.nameLabel.text = reward.userName;
    self.memberTypeLabel.text = @"Plus Member";
    self.ammountLabel.text = [NSString stringWithFormat:@"$%@",reward.amount];
    self.rewardTypeLabel.text = @"Redeemable";
    self.barcodeNumber.text = [NSString stringWithFormat:@"%@",reward.number];
    [self setBarCode:reward.number];
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
