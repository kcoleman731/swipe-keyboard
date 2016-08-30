//
//  STItemCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProductItem.h"

extern NSString *const BOTBackToSchoolViewCartButtonTappedNotification;

@class BOTItemCollectionViewCell;

@protocol BOTItemCollectionViewCellDelegate

- (void)ItemCell:(BOTItemCollectionViewCell *)cell addButtonWasPressedWithItem:(BOTProductItem *)item;

- (void)ItemCell:(BOTItemCollectionViewCell *)cell infoButtonWasPressedWithItem:(BOTProductItem *)item;

@end

@interface BOTItemCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) BOTProductItem *item;

@property (nonatomic, weak) id <BOTItemCollectionViewCellDelegate> delegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(BOTProductItem *)item;

@end
