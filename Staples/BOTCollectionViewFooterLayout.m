//
//  BOTCollectionViewFooterLayout.m
//  Staples
//
//  Created by Kevin Coleman on 10/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTCollectionViewFooterLayout.h"

@implementation BOTCollectionViewFooterLayout

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

@end
