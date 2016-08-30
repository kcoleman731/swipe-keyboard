//
//  STMultipleProductsBaseCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTMultipleProductBaseCollectionViewCell.h"
#import "BOTMultipleProductsCollectionViewLayout.h"
#import "BOTShipmentTrackingCollectionViewCell.h"
#import "BOTRewardCollectionViewCell.h"
#import "BOTUtilities.h"

NSString *const BOTMultipleProductBaseCollectionViewCellTitle = @"Product Cell";
NSString *const BOTMultipleProductBaseCollectionViewCellId = @"BOTMultipleProductBaseCollectionViewCellId";

// NSNotificationKeys
NSString *const BOTBackToSchoolViewAllSelectedNotification = @"BOTBackToSchoolViewAllSelectedNotification";
NSString *const BOTBackToSchoolItemSelectedNotification = @"BOTBackToSchoolItemSelectedNotification";
NSString *const BOTShipmentSelectedNotification = @"BOTShipmentSelectedNotification";
NSString *const BOTRewardSelectedNotification = @"BOTRewardSelectedNotification";

// JSON Parsing Keys
NSString *const BOTMessagePartCartItemsKey = @"cartItems";
NSString *const BOTMessagePartBTSItemsKey = @"btsItems";
NSString *const BOTMessagePartListItemsKey = @"listItems";
NSString *const BOTMessagePartHeaderTitle = @"headerTitle";
NSString *const BOTMessagePartShipmentTrackingListKey = @"shippmentTrackingList";
NSString *const BOTMessagePartRewardListKey = @"rewardslistItems";

typedef NS_ENUM(NSInteger, BOTCellType) {
    BOTCellTypeBackToSchool = 0,
    BOTCellTypeShipping = 1,
    BOTCellTypeRewards = 2,
};

@interface BOTMultipleProductBaseCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) LYRMessage *message;
@property (nonatomic) BOTCellType cellType;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BOTMultipleProductsCollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UILabel *btsHeaderLable;
@property (nonatomic, strong) UIButton *viewAllButton;
@property (nonatomic, strong) NSLayoutConstraint *topCollectionViewConstraint;

@end

@implementation BOTMultipleProductBaseCollectionViewCell

CGFloat const BOTHeaderLabelTopInset = 8.0f;
CGFloat const BOTHeaderLabelHorizontalInset = 20.0f;
CGFloat const BOTCollectionViewTopInset = 22.0f;

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

    UINib *itemNib = [UINib nibWithNibName:@"BOTItemCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:itemNib forCellWithReuseIdentifier:[BOTItemCollectionViewCell reuseIdentifier]];
    
    UINib *productNib = [UINib nibWithNibName:@"BOTProductCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:productNib forCellWithReuseIdentifier:[BOTProductCollectionViewCell reuseIdentifier]];

    UINib *shippingNib = [UINib nibWithNibName:@"BOTShipmentTrackingCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:shippingNib forCellWithReuseIdentifier:[BOTShipmentTrackingCollectionViewCell reuseIdentifier]];

    UINib *rewardNib = [UINib nibWithNibName:@"BOTRewardCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:rewardNib forCellWithReuseIdentifier:[BOTRewardCollectionViewCell reuseIdentifier]];
}

- (void)layoutCollectionView
{
    self.btsHeaderLable = [UILabel new];
    self.btsHeaderLable.font = [UIFont systemFontOfSize:14];
    self.btsHeaderLable.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.btsHeaderLable];
    
    self.viewAllButton = [UIButton new];
    self.viewAllButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewAllButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.viewAllButton setTitleColor:BOTBlueColor() forState:UIControlStateNormal];
    [self.viewAllButton addTarget:self action:@selector(viewAllButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.viewAllButton];
    
    self.collectionViewLayout = [[BOTMultipleProductsCollectionViewLayout alloc] init];
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
    return BOTMultipleProductBaseCollectionViewCellId;
}

+ (CGFloat)cellHeightForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        return [BOTItemCollectionViewCell cellHeight] + 46;
    } else if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        return [BOTShipmentTrackingCollectionViewCell cellHeight];
    }
    return 260;
}

#pragma mark - Reuse

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.viewAllButton setTitle:@"" forState:UIControlStateNormal];
    [self.viewAllButton sizeToFit];
    
    self.btsHeaderLable.text = @"";
    [self.btsHeaderLable sizeToFit];
    
    self.topCollectionViewConstraint.constant = 0;
}

#pragma mark - ATLMessagePresenting

- (void)presentMessage:(LYRMessage *)message
{
    self.message = message;
    LYRMessagePart *part = message.parts[0];
    [self setCellTypeForMessagePart:part];

    self.items = [self cellItemsForMessage:message];
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
    return CGSizeMake(collectionView.bounds.size.width * 0.8f, collectionView.bounds.size.height * 0.95f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.cellType) {
        case BOTCellTypeBackToSchool: {
            NSNotification *notification = [NSNotification notificationWithName:BOTBackToSchoolItemSelectedNotification object:self.items[indexPath.row]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
            break;

        case BOTCellTypeRewards: {
            NSNotification *notification = [NSNotification notificationWithName:BOTRewardSelectedNotification object:self.items[indexPath.row]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
            break;

        case BOTCellTypeShipping: {
            NSNotification *notification = [NSNotification notificationWithName:BOTShipmentSelectedNotification object:self.items[indexPath.row]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
            break;

        default:
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *returnCell;
    switch (self.cellType) {
        case BOTCellTypeBackToSchool: {
            NSString *reuseIdentifier = [BOTItemCollectionViewCell reuseIdentifier];
            BOTItemCollectionViewCell *cell = (BOTProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            BOTProductItem *item = self.items[indexPath.row];
            [cell setProductItem:item];
            returnCell = cell;
        }

            break;
        case BOTCellTypeRewards: {
            NSString *reuseIdentifier = [BOTRewardCollectionViewCell reuseIdentifier];
            BOTRewardCollectionViewCell *cell = (BOTRewardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            BOTReward *item = self.items[indexPath.row];
            [cell setReward:item];
            returnCell = cell;
        }

            break;
        case BOTCellTypeShipping: {
            NSString *reuseIdentifier = [BOTShipmentTrackingCollectionViewCell reuseIdentifier];
            BOTShipmentTrackingCollectionViewCell *cell = (BOTShipmentTrackingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            BOTShipment *shipment = self.items[indexPath.row];
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

- (void)setCellTypeForMessagePart:(LYRMessagePart *)part
{
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        self.cellType = BOTCellTypeBackToSchool;
    } else if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        self.cellType = BOTCellTypeRewards;
    } else if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        self.cellType = BOTCellTypeShipping;
    }
}

- (NSArray *)cellItemsForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *json = [self parseDataForMessagePart:part];

    // Parse Product Data.
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        
        // Parse BTS Title
        NSDictionary *data = json[BOTMessagePartDataKey];
        NSDictionary *itemsData;
        
        if(data[STMessagePartBTSItemsKey])
            itemsData = data[STMessagePartBTSItemsKey];
        else if(data[STMessagePartCartItemsKey])
           itemsData = data[STMessagePartCartItemsKey];
        
        //BTS items and cart items are coming in mupltiple part, so Handled number of parts
        /// Parse BTS Items
        for(int i=1; i<self.message.parts.count; i++){
            LYRMessagePart *part = self.message.parts[i];
            NSDictionary *json = [self parseDataForMessagePart:part];
            NSDictionary *itemData = json[BOTMessagePartDataKey];
            NSArray *itemJSON = itemData[BOTMessagePartListItemsKey];
            for (NSDictionary *itemData in itemJSON) {
                STProductItem *item = [BOTProductItem productWithData:itemData];
                [items addObject:item];
            }
       }
        // Update View
        self.btsHeaderLable.text = itemsData[BOTMessagePartHeaderTitle];
        [self.btsHeaderLable sizeToFit];
        
        [self.viewAllButton setTitle:@"View All" forState:UIControlStateNormal];
        [self.viewAllButton sizeToFit];
        
        self.topCollectionViewConstraint.constant = BOTCollectionViewTopInset;
    }

    // Parse Reward Data.
    if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        NSDictionary *data = json[BOTMessagePartDataKey];
        NSArray *rewardJSON = data[BOTMessagePartRewardListKey];
        for (NSDictionary *itemData in rewardJSON) {
            BOTReward *reward = [BOTReward rewardWithData:itemData];
            [items addObject:reward];
        }
    }

    // Parse Shipping Data.
    if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        NSDictionary *data = json[BOTMessagePartDataKey];
        NSArray *shipmentJSON = data[BOTMessagePartShipmentTrackingListKey];
        for (NSDictionary *itemData in shipmentJSON) {
            BOTShipment *item = [BOTShipment shipmentWithData:itemData];
            [items addObject:item];
        }
    }
    return items;
}

- (NSDictionary *)parseDataForMessagePart:(LYRMessagePart *)part
{
    NSString *dataString = [[NSString alloc] initWithData:part.data encoding:NSUTF8StringEncoding];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return json;
}

#pragma mark - BTS View All Button Tap

- (void)viewAllButtonWasTapped:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTBackToSchoolViewAllSelectedNotification object:self.items];
}

#pragma mark - NSLayoutConstraints For UI

- (void)addCollecitonViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btsHeaderLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:BOTHeaderLabelTopInset]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btsHeaderLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:BOTHeaderLabelHorizontalInset]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewAllButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btsHeaderLable attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewAllButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-BOTHeaderLabelHorizontalInset]];
    
    self.topCollectionViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    [self addConstraint:self.topCollectionViewConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
}

@end
