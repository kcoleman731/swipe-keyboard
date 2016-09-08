//
//  BOTOrderStatusBaseCollectionViewCellDataSource.m
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderStatusViewCell.h"
#import "BOTOrderStatusBaseCollectionViewCellDataSource.h"
#import "BOTOrderCollectionViewCellProductCollectionViewCell.h"

@interface BOTOrderStatusBaseCollectionViewCellDataSource ()

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation BOTOrderStatusBaseCollectionViewCellDataSource

#pragma mark - Init / layout

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        self.collectionView.dataSource = self;
        [self registerOrderCell];
    }
    return self;
}

- (void)registerOrderCell
{
    UINib *orderStatusCell = [UINib nibWithNibName:@"BOTOrderStatusViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:orderStatusCell forCellWithReuseIdentifier:[BOTOrderStatusViewCell reuseIdentifier]];
}

- (void)setShipments:(NSArray<BOTShipment *> *)shipments
{
    if (_shipments != shipments) {
        _shipments = shipments;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.shipments.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOTOrderStatusViewCell *cell = (BOTOrderStatusViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate shipmentWasTapped:cell.shipment];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOTOrderStatusViewCell *cell = (BOTOrderStatusViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[BOTOrderStatusViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell setShipment:self.shipments[indexPath.row]];
    return cell;
}

@end
