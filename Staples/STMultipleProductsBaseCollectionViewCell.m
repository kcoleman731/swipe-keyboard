//
//  STMultipleProductsBaseCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleProductsBaseCollectionViewCell.h"
#import "STMultipleProductsBaseCollectionViewCellDataSource.h"
#import "STMultipleProductsCollectionViewLayout.h"

@interface STMultipleProductsBaseCollectionViewCell () <UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) STMultipleProductsBaseCollectionViewCellDataSource *dataSource;
@property (nonatomic, strong) STMultipleProductsCollectionViewLayout *collectionViewLayout;

@end

@implementation STMultipleProductsBaseCollectionViewCell

#pragma mark - Initializers / Common Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self layoutCollectionView];
    [self configureDataSource];
    
}

- (void)layoutCollectionView
{
    self.collectionView = [[UICollectionView alloc] init];
    self.collectionViewLayout = [[STMultipleProductsCollectionViewLayout alloc] init];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.collectionViewLayout = self.collectionViewLayout;
    [self addSubview:self.collectionView];
    [self addCollecitonViewConstraints];
}

- (void)configureDataSource
{
    self.dataSource = [[STMultipleProductsBaseCollectionViewCellDataSource alloc] initWithCollectionView:self.collectionView];
    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Setter For Data

- (void)setProducts:(NSArray <STProductItem *> *)items
{
    [self.dataSource setProducts:items];
}

#pragma mark - Collection View Delegate Calls



#pragma mark - NSLayoutConstraints For UI

- (void)addCollecitonViewConstraints
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    [self addConstraints:@[top, left, right, bottom]];
}

@end
