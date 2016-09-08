//
//  BOTOrderStatusBaseCollectionViewCellDataSource.h
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOTOrderStatusViewCell.h"
#import <UIKit/UIKit.h>
#import "BOTShipment.h"

@interface BOTOrderStatusBaseCollectionViewCellDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <BOTShipment *> *shipments;
@property (nonatomic, weak) id <BOTOrderStatusViewCellDelegate> delegate;

/**
 *  Init
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end