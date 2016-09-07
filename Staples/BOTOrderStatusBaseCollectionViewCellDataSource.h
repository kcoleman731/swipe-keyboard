//
//  BOTOrderStatusBaseCollectionViewCellDataSource.h
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BOTShipment.h"

@protocol BOTOrderStatusBaseCollectionViewCellDataSourceDelegate

- (void)shipmentWasTapped:(BOTShipment *)shipment;

@end

@interface BOTOrderStatusBaseCollectionViewCellDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <BOTShipment *> *shipments;
@property (nonatomic, weak) id <BOTOrderStatusBaseCollectionViewCellDataSourceDelegate> delegate;

/**
 *  Init
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end