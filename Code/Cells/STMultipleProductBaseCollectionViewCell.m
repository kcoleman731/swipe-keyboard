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

NSString *const BOTMultipleProductBaseCollectionViewCellTitle = @"Product Cell";
NSString *const BOTMultipleProductBaseCollectionViewCellId = @"BOTMultipleProductBaseCollectionViewCellId";

// NSNotificationKeys
NSString *const BOTBackToSchoolViewAllSelectedNotification = @"BOTBackToSchoolViewAllSelectedNotification";
NSString *const BOTBackToSchoolItemSelectedNotification = @"BOTBackToSchoolItemSelectedNotification";
NSString *const BOTShipmentSelectedNotification = @"BOTShipmentSelectedNotification";
NSString *const BOTRewardSelectedNotification = @"BOTRewardSelectedNotification";

// JSON Parsing Keys
NSString *const STMessagePartCartItemsKey = @"cartItems";
NSString *const STMessagePartBTSItemsKey = @"btsItems";
NSString *const STMessagePartListItemsKey = @"listItems";
NSString *const STMessagePartHeaderTitle = @"headerTitle";
NSString *const STMessagePartShipmentTrackingListKey = @"shippmentTrackingList";
NSString *const STMessagePartRewardListKey = @"rewardslistItems";

typedef NS_ENUM(NSInteger, STCellType) {
    STCellTypeBackToSchool = 0,
    STCellTypeShipping = 1,
    STCellTypeRewards = 2,
};

@interface STMultipleProductBaseCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) LYRMessage *message;
@property (nonatomic) STCellType cellType;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) STMultipleProductsCollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UILabel *btsHeaderLable;
@property (nonatomic, strong) UIButton *viewAllButton;
@property (nonatomic, strong) NSLayoutConstraint *topCollectionViewConstraint;

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
    self.btsHeaderLable = [UILabel new];
    self.btsHeaderLable.font = [UIFont systemFontOfSize:14];
    self.btsHeaderLable.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.btsHeaderLable];
    
    self.viewAllButton = [UIButton new];
    self.viewAllButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewAllButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.viewAllButton setTitleColor:STBlueColor() forState:UIControlStateNormal];
    [self.viewAllButton addTarget:self action:@selector(viewAllButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.viewAllButton];
    
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
    return BOTMultipleProductBaseCollectionViewCellId;
}

+ (CGFloat)cellHeightForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        return [STProductCollectionViewCell cellHeight] + 60;
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
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
    return CGSizeMake(collectionView.bounds.size.width * 0.8f, collectionView.bounds.size.height * 0.9f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.cellType) {
        case STCellTypeBackToSchool: {
            NSNotification *notification = [NSNotification notificationWithName:BOTBackToSchoolItemSelectedNotification object:self.items[indexPath.row]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
            break;

        case STCellTypeRewards: {
            NSNotification *notification = [NSNotification notificationWithName:BOTRewardSelectedNotification object:self.items[indexPath.row]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
            break;

        case STCellTypeShipping: {
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
        case STCellTypeBackToSchool: {
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

- (void)setCellTypeForMessagePart:(LYRMessagePart *)part
{
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        self.cellType = STCellTypeBackToSchool;
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        self.cellType = STCellTypeRewards;
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        self.cellType = STCellTypeShipping;
    }
}

- (NSArray *)cellItemsForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *json = [self parseDataForMessagePart:part];

    // Parse Product Data.
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        // Parse BTS Title
        NSDictionary *data = json[STMessagePartDataKey];
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
            NSDictionary *itemData = json[STMessagePartDataKey];
            NSArray *itemJSON = itemData[STMessagePartListItemsKey];
            for (NSDictionary *itemData in itemJSON) {
                STProductItem *item = [STProductItem productWithData:itemData];
                [items addObject:item];
            }
       }
        // Update View
        self.btsHeaderLable.text = itemsData[STMessagePartHeaderTitle];
        [self.btsHeaderLable sizeToFit];
        
        [self.viewAllButton setTitle:@"View All" forState:UIControlStateNormal];
        [self.viewAllButton sizeToFit];
        
        self.topCollectionViewConstraint.constant = 40;
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btsHeaderLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btsHeaderLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewAllButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btsHeaderLable attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewAllButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
    
    self.topCollectionViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    [self addConstraint:self.topCollectionViewConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
}

@end
