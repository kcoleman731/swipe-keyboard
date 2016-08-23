//
//  STReorderItemCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProductItem.h"

@interface STReorderItemCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setProductItem:(STProductItem *)item;


@end
