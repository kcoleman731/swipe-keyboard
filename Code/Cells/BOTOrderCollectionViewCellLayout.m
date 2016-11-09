//
//  BOTOrderCollectionViewCellLayout.m
//  Staples
//
//  Created by Taylor Halliday on 9/2/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderCollectionViewCellLayout.h"

@implementation BOTOrderCollectionViewCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width / 3.0f, collectionView.bounds.size.height);
}

@end
