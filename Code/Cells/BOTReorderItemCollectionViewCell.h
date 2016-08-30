//
//  STReorderItemCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProductItem.h"

@interface BOTReorderItemCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(BOTProductItem *)item;


@end
