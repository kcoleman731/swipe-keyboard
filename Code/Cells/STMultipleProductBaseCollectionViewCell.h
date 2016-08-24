//
//  STMultipleProductsBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "STSuggestedProductCollectionViewCell.h"
#import "STItemCollectionViewCell.h"
#import "STProductItem.h"

extern NSString *const STMultipleProductBaseCollectionViewCellTitle;

@interface STMultipleProductBaseCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

@property (nonatomic, weak) id <STSuggestedProductCollectionViewCellDelegate> productDelegate;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Cell Height
 */
+ (CGFloat)cellHeight;

@end
