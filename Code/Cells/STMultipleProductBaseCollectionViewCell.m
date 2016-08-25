//
//  STMultipleProductsBaseCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleProductBaseCollectionViewCell.h"
#import "STMultipleProductsCollectionViewLayout.h"
#import "BOTShipmentTrackingCollectionViewCell.h"
#import "BOTRewardCollectionViewCell.h"
#import "STUtilities.h"

NSString *const STMultipleProductBaseCollectionViewCellTitle = @"Product Cell";
NSString *const STMultipleProductBaseCollectionViewCellId = @"STMultipleProductBaseCollectionViewCellId";
NSString *const STShipmentSelectedNotification = @"STShipmentSelectedNotification";
NSString *const STRewardSelectedNotification = @"STRewardSelectedNotification";

typedef NS_ENUM(NSInteger, STCellType) {
    STCellTypeProduct = 0,
    STCellTypeItem = 1,
    STCellTypeShipping = 2,
    STCellTypeRewards = 3,
};

@interface STMultipleProductBaseCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, STSuggestedProductCollectionViewCellDelegate>

@property (nonatomic) STCellType cellType;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) STMultipleProductsCollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *items;

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
    
    UINib *productNib = [UINib nibWithNibName:@"STProductCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:productNib forCellWithReuseIdentifier:[STProductCollectionViewCell reuseIdentifier]];
    
    UINib *shippingNib = [UINib nibWithNibName:@"BOTShipmentTrackingCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:shippingNib forCellWithReuseIdentifier:[BOTShipmentTrackingCollectionViewCell reuseIdentifier]];
    
    UINib *rewardNib = [UINib nibWithNibName:@"BOTRewardCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:rewardNib forCellWithReuseIdentifier:[BOTRewardCollectionViewCell reuseIdentifier]];
}

- (void)layoutCollectionView
{
    self.collectionViewLayout = [[STMultipleProductsCollectionViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 16.0, 0.0, 0.0);
    self.collectionView.contentOffset = CGPointMake(16.0, 0.0);
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = self.collectionViewLayout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;

    [self addSubview:self.collectionView];
    
    [self addCollecitonViewConstraints];
}

+ (NSString *)reuseIdentifier
{
    return STMultipleProductBaseCollectionViewCellId;
}

+ (CGFloat)cellHeightForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        return [STProductCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        return [BOTShipmentTrackingCollectionViewCell cellHeight];
    }
    return 260;
}

#pragma mark - ATLMessagePresenting

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    [self setCellTypeForMessagePart:part];
    
    self.items = [self cellItemsForMessagePart:part];
    [self.collectionView reloadData];
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // Nothing to do.
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // Nothing to do
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width * 0.8f, collectionView.bounds.size.height * 0.9f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotification *notification;
    switch (self.cellType) {
        case STCellTypeProduct:
            //notification = [NSNotification notificationWithName:STShipmentSelectedNotification object:self.items[indexPath.row]];
            
            break;
        case STCellTypeRewards:
            notification = [NSNotification notificationWithName:STRewardSelectedNotification object:self.items[indexPath.row]];
            
            break;
        case STCellTypeShipping:
            notification = [NSNotification notificationWithName:STShipmentSelectedNotification object:self.items[indexPath.row]];
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *returnCell;
    switch (self.cellType) {
        case STCellTypeProduct: {
            NSString *reuseIdentifier = [STProductCollectionViewCell reuseIdentifier];
            STProductCollectionViewCell *cell = (STProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            STProductItem *item = self.items[indexPath.row];
            [cell setProductItem:item];
            returnCell = cell;
        }
            
            break;
        case STCellTypeRewards: {
            NSString *reuseIdentifier = [BOTRewardCollectionViewCell reuseIdentifier];
            BOTRewardCollectionViewCell *cell = (BOTRewardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            STReward *item = self.items[indexPath.row];
            [cell setReward:item];
            returnCell = cell;
        }
            
            break;
        case STCellTypeShipping: {
            NSString *reuseIdentifier = [BOTShipmentTrackingCollectionViewCell reuseIdentifier];
            BOTShipmentTrackingCollectionViewCell *cell = (BOTShipmentTrackingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            STShipment *shipment = self.items[indexPath.row];
            [cell setShipment:shipment];
            returnCell = cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return returnCell;
}

#pragma mark - Data Parsing

NSString *const STMessagePartBTSItemsKey = @"btsItems";
NSString *const STMessagePartListItemsKey = @"listItems";
NSString *const STMessagePartShipmentTrackingListKey = @"shippmentTrackingList";
NSString *const STMessagePartRewardListKey = @"rewardslistItems";

- (void)setCellTypeForMessagePart:(LYRMessagePart *)part
{
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        self.cellType = STCellTypeProduct;
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        self.cellType = STCellTypeRewards;
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        self.cellType = STCellTypeShipping;
    }
}

- (NSArray *)cellItemsForMessagePart:(LYRMessagePart *)part
{
    NSString *dataString = [[NSString alloc] initWithData:part.data encoding:NSUTF8StringEncoding];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    
    // Parse Product Data.
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        NSArray *itemJSON;
        NSDictionary *data = json[STMessagePartDataKey];
        if (data[STMessagePartBTSItemsKey]) {
            itemJSON = data[STMessagePartBTSItemsKey];
        } else if (data[STMessagePartListItemsKey]) {
            itemJSON = data[STMessagePartListItemsKey];
        }

        for (NSDictionary *itemData in itemJSON) {
            STProductItem *item = [STProductItem productWithData:itemData];
            [items addObject:item];
        }
    }
    
    // Parse Reward Data.
    if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        NSDictionary *data = json[STMessagePartDataKey];
        NSArray *rewardJSON = data[STMessagePartRewardListKey];
        for (NSDictionary *itemData in rewardJSON) {
            STReward *reward = [STReward rewardWithData:itemData];
            [items addObject:reward];
        }
    }
    
    // Parse Shipping Data.
    if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        NSDictionary *data = json[STMessagePartDataKey];
        NSArray *shipmentJSON = data[STMessagePartShipmentTrackingListKey];
        for (NSDictionary *itemData in shipmentJSON) {
            STShipment *item = [STShipment shipmentWithData:itemData];
            [items addObject:item];
        }
    }
    return items;
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
}

@end
