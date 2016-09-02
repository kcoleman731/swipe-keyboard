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
    return CGSizeMake(collectionView.bounds.size.width / 4.0f, collectionView.bounds.size.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    
    for (int i = 1; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger maximumSpacing = 1;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if ((origin + maximumSpacing + currentLayoutAttributes.frame.size.width) < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            frame.origin.y = 1.0;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    // Set first
    UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[0];
    CGRect frame                  = currentLayoutAttributes.frame;
    frame.origin.y                = 1.0;
    currentLayoutAttributes.frame = frame;
    
    return answer;
}

@end
