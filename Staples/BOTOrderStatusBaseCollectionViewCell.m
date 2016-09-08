//
//  BOTOrderStatusBaseCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderStatusBaseCollectionViewCell.h"
#import "BOTOrderStatusBaseCollectionViewCellLayout.h"
#import "BOTOrderStatusBaseCollectionViewCellDataSource.h"
#import "BOTShipment.h"
#import "BOTUtilities.h"

NSString *const BOTOrderStatusBaseCollectionViewCellTitle = @"BOTOrderStatusBaseCollectionViewCellTitle";
NSString *const BOTOrderStatusBaseCollectionViewCellMimeType = @"BOTOrderStatusBaseCollectionViewCellMimeType";
NSString *const BOTOrderStatusBaseCollectionViewCellReuseIdentifier = @"BOTOrderStatusBaseCollectionViewCellReuseIdentifier";
NSString *const ShipmentTrackingPayloadListKey = @"shippmentTrackingList";

@interface BOTOrderStatusBaseCollectionViewCell()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BOTOrderStatusBaseCollectionViewCellLayout *collectionViewLayout;
@property (nonatomic, strong) BOTOrderStatusBaseCollectionViewCellDataSource *dataSource;

@end

@implementation BOTOrderStatusBaseCollectionViewCell

#pragma mark - Class Methods

/**
 Cell height
 */
+ (CGFloat)cellHeight
{
    return 220.0f;
}

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier
{
    return BOTOrderStatusBaseCollectionViewCellReuseIdentifier;
}

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
}

- (void)layoutCollectionView
{
    self.collectionViewLayout = [[BOTOrderStatusBaseCollectionViewCellLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    self.dataSource = [[BOTOrderStatusBaseCollectionViewCellDataSource alloc] initWithCollectionView:self.collectionView];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);
    self.collectionView.contentOffset = CGPointMake(16.0, 0.0);
    self.collectionView.delegate = self.collectionViewLayout;
    self.collectionView.collectionViewLayout = self.collectionViewLayout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.collectionView];
    [self addCollectionViewConstraints];
}

#pragma mark - ATLMessagePresentingConformance

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part   = message.parts[0];
    NSDictionary *data     = DataForMessagePart(part);
    NSArray *jsonShipments = data[@"data"][ShipmentTrackingPayloadListKey];
    NSMutableArray <BOTShipment *> *shipments = [[NSMutableArray alloc] init];
    for (NSDictionary *shipmentDict in jsonShipments) {
        [shipments addObject:[BOTShipment shipmentWithData:shipmentDict]];
    }
    self.dataSource.shipments = [shipments copy];
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // Nada for now
}

- (void)updateWithSender:(id<ATLParticipant>)sender
{
    // Nada
}

#pragma mark - Layout Constraints

- (void)addCollectionViewConstraints
{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                           attribute:NSLayoutAttributeTop 
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0];
    
    [self addConstraints:@[leading, trailing, top, bottom]];
}

@end
