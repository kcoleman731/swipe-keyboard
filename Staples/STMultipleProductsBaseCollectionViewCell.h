//
//  STMultipleProductsBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "STMultipleProductsCollectionViewCell.h"
#import "STProductItem.h"

extern NSString *const STMultipleProductsBaseCollectionViewCellTitle;
extern NSString *const STMultipleProductsBaseCollectionViewCellMimeType;

@interface STMultipleProductsBaseCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

@property (nonatomic, weak) id <STMultipleProductsCollectionViewCellDelegate> productDelegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

/**
 *  Product Items Setter
 */
- (void)setProducts:(NSArray <STProductItem *> *)items;


@end
