//
//  STMultipleProductsBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "STProductCollectionViewCell.h"
#import "STItemCollectionViewCell.h"
#import "STProductItem.h"

extern NSString *const STMultipleProductBaseCollectionViewCellTitle;
extern NSString *const STMultipleProductBaseCollectionViewCellMimeType;

@interface STMultipleProductBaseCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

@property (nonatomic, weak) id <STProductCollectionViewCellDelegate> productDelegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Cell Height
 */
+ (CGFloat)cellHeight;

@end
