//
//  STRewardCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "BOTReward.h"

/**
 The title of the cell. Used for testing purposes.
 */
extern NSString *const BOTRewardCollectionViewCellTitle;

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTRewardCollectionViewCellReuseIdentifier;

/**
 The `BOTRewardCollectionViewCell` displays an `BOT Card` with information about a staples reward.
 */
@interface BOTRewardCollectionViewCell : UICollectionViewCell

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeight;

/**
 Reward Setter
 */
- (void)setReward:(BOTReward *)reward;

@end
