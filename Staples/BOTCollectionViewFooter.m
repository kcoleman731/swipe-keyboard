//
//  BOTCollectionViewFooter.m
//  Staples
//
//  Created by Kevin Coleman on 10/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTCollectionViewFooter.h"
#import "BOTCollectionViewFooterCell.h"
#import "BOTCollectionViewFooterLayout.h"

NSString *const BOTCollectionViewFooterItemSelectedNotification = @"BOTCollectionViewFooterItemSelectedNotification";
NSString *const BOTCollectionViewFooterReuseIdentifier = @"BOTCollectionViewFooterReuseIdentifier";

@interface BOTCollectionViewFooter () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSArray *selectionTitles;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation BOTCollectionViewFooter

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
    [self layoutCollectionView];
    [self.collectionView registerClass:[BOTCollectionViewFooterCell class] forCellWithReuseIdentifier:BOTCollectionViewFooterCellReuseIdentifier];
}

- (void)updateWithSelectionTitle:(NSArray *)selectionTitles
{
    self.selectionTitles = selectionTitles;
}

- (void)layoutCollectionView
{
    self.collectionViewLayout = [BOTCollectionViewFooterLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView .backgroundColor = [UIColor whiteColor];
    self.collectionView.collectionViewLayout = self.collectionViewLayout;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.collectionView];
    [self configureCollectionViewConstraints];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width * 0.45f, collectionView.bounds.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selection = self.selectionTitles[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTCollectionViewFooterItemSelectedNotification object:selection];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = BOTCollectionViewFooterCellReuseIdentifier;
    BOTCollectionViewFooterCell *cell = (BOTCollectionViewFooterCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateWithTitle:self.selectionTitles[indexPath.row]];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (void)configureCollectionViewConstraints
{
    // Collection View Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
}

+ (NSString *)reuseIdentifier
{
    return BOTCollectionViewFooterReuseIdentifier;
}

- (void)updateWithAttributedStringForRecipientStatus:(nullable NSAttributedString *)recipientStatus
{
    //
}

+ (CGFloat)footerHeightWithRecipientStatus:(nullable NSAttributedString *)recipientStatus  clustered:(BOOL)clustered
{
    return 120;
}

@end
