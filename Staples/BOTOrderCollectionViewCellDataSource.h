//
//  BOTOrderCollectionViewCellDataSource.h
//  Staples
//
//  Created by Taylor Halliday on 9/2/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BOTOrder.h"

@protocol BOTOrderCollectionViewCellDataSourceDelegate

- (void)productWasTapped:(BOTProduct *)product;

@end

@interface BOTOrderCollectionViewCellDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, weak) id <BOTOrderCollectionViewCellDataSourceDelegate> delegate;

/**
 *  Init
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 *  Order setter
 */
- (void)setOrder:(BOTOrder *)order;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

@end
