//
//  STMultipleProductsBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMultipleProductsCollectionViewCell.h"
#import "STProductItem.h"

@interface STMultipleProductsBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <STMultipleProductsCollectionViewCellDelegate> productDelegate;

- (void)setProducts:(NSArray <STProductItem *> *)items;

@end
