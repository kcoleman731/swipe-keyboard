//
//  STItemCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProductItem.h"

@class STItemCollectionViewCell;

@protocol STItemCollectionViewCellDelegate

- (void)ItemCell:(STItemCollectionViewCell *)cell addButtonWasPressedWithItem:(STProductItem *)item;

- (void)ItemCell:(STItemCollectionViewCell *)cell infoButtonWasPressedWithItem:(STProductItem *)item;

@end

@interface STItemCollectionViewCell : UICollectionViewCell

@property (readonly, nonatomic, strong) STProductItem *item;

@property (nonatomic, weak) id <STItemCollectionViewCellDelegate> delegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(STProductItem *)item;

@end
