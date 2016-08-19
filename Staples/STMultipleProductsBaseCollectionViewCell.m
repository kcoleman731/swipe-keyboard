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

NSString *const STMultipleProductsBaseCollectionViewCellId = @"STMultipleProductsBaseCollectionViewCellId";

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
    self.collectionViewLayout = [[STMultipleProductsCollectionViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 16.0, 0.0, 0.0);
    self.collectionView.contentOffset = CGPointMake(16.0, 0.0);
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self.collectionViewLayout;
    self.collectionView.collectionViewLayout = self.collectionViewLayout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self addCollecitonViewConstraints];
}

- (void)configureDataSource
{
    self.dataSource = [[STMultipleProductsBaseCollectionViewCellDataSource alloc] initWithCollectionView:self.collectionView];
    self.collectionView.dataSource = self.dataSource;
}

+ (NSString *)reuseIdentifier
{
    return STMultipleProductsBaseCollectionViewCellId;
}

#pragma mark - Setter For Data

- (void)setProducts:(NSArray <STProductItem *> *)items
{
    [self.dataSource setProducts:items];
}

#pragma mark - Collection View Delegate Calls

#pragma mark - ATLMessagePresenting

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSArray *data = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (NSDictionary *dataDict in data) {
        STProductItem *item = [[STProductItem alloc] initWithDictionaryPayload:dataDict];
        [products addObject:item];
    }
    
    // Set the decoded products
    [self setProducts:[products copy]];
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // ???
}


- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // ??
}

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
