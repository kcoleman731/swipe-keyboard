//
//  STRewardCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "STReward.h"

extern NSString *const BOTRewardCollectionViewCellTitle;
extern NSString *const BOTRewardCollectionViewCellReuseIdentifier;

@interface BOTRewardCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *memberTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ammountLabel;
@property (strong, nonatomic) IBOutlet UILabel *rewardTypeLabel;
@property (strong, nonatomic) IBOutlet UIButton *viewButton;
@property (strong, nonatomic) IBOutlet UIImageView *barcodeImage;
@property (strong, nonatomic) IBOutlet UILabel *barcodeNumber;

- (void)setReward:(STReward *)reward;

+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

@end
