//
//  STMultipleProductsBaseCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleProductBaseCollectionViewCell.h"
#import "STMultipleProductsBaseCollectionViewCellDataSource.h"
#import "STMultipleProductsCollectionViewLayout.h"

NSString *const STMultipleProductBaseCollectionViewCellTitle = @"Product Cell";
NSString *const STMultipleProductBaseCollectionViewCellMimeType = @"json/product";
NSString *const STMultipleProductBaseCollectionViewCellId = @"STMultipleProductBaseCollectionViewCellId";

@interface STMultipleProductBaseCollectionViewCell () <UICollectionViewDelegate, STMultipleProductsCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) STMultipleProductsBaseCollectionViewCellDataSource *dataSource;
@property (nonatomic, strong) STMultipleProductsCollectionViewLayout *collectionViewLayout;

@end

@implementation STMultipleProductBaseCollectionViewCell

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
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    [self addCollecitonViewConstraints];
}

- (void)configureDataSource
{
    self.dataSource = [[STMultipleProductsBaseCollectionViewCellDataSource alloc] initWithCollectionView:self.collectionView cellDelegate:self];
    self.collectionView.dataSource = self.dataSource;
}

+ (NSString *)reuseIdentifier
{
    return STMultipleProductBaseCollectionViewCellId;
}

+ (CGFloat)cellHeight
{
    return 140;
}

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
    [self.dataSource setProducts:[products copy]];
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // ???
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // ??
}

#pragma mark - STMultipleProductsCollectionViewCellDelegate Calls

- (void)productCell:(STProductCollectionViewCell *)cell addButtonWasPressedWithProduct:(STProductItem *)item
{
    [self.productDelegate productCell:cell addButtonWasPressedWithProduct:item];
}

- (void)productCell:(STProductCollectionViewCell *)cell infoButtonWasPressedWithProduct:(STProductItem *)item
{
    [self.productDelegate productCell:cell infoButtonWasPressedWithProduct:item];
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
