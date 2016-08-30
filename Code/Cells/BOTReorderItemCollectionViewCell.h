//
//  STReorderItemCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProductItem.h"

/**
 The `BOTReorderItemCollectionViewCell` displays an individual reorder item cell.
 */
@interface BOTReorderItemCollectionViewCell : UICollectionViewCell

/**
 Reuse identifier.
 */
+ (NSString *)reuseIdentifier;

/**
 Product Items Setter
 */
- (void)setProductItem:(BOTProductItem *)item;


@end
