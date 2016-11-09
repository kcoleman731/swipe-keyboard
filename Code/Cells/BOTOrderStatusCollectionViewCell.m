//
//  BOTOrderStatusViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderStatusCollectionViewCell.h"
#import "BOTUtilities.h"
#import "UIImageView+WebCache.h"
#import "EDColor.h"

NSString *const BOTOrderStatusCollectionViewCellTitle           = @"BOTOrderStatusCollectionViewCellTitle";
NSString *const BOTOrderStatusCollectionViewCellMimeType        = @"BOTOrderStatusCollectionViewCellMimeType";
NSString *const BOTOrderStatusCollectionViewCellReuseIdentifier = @"BOTOrderStatusCollectionViewCellReuseIdentifier";
NSString *const BOTTrackOrderShipmentButtonTapNotification      = @"BOTTrackOrderShipmentButtonTapNotification";
NSString *const BOTViewAllOrdersButtonTapNotification           = @"BOTViewAllOrdersButtonTapNotification";

// UI Color Hexs
NSString *const blueColorCode  = @"4a90e2";
NSString *const greenColorCode = @"77a53b";
NSString *const grayColorCode  = @"9b9b9b";

@interface BOTOrderStatusCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *trackShipmentBottomButton;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreItemsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shipmentStatusImageView;
@property (weak, nonatomic) IBOutlet UILabel *shipmentStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimatedDeliveryLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimatedDeliveryDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewAllButton;

// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productTitleLabelTopConstraint;

@end

@implementation BOTOrderStatusCollectionViewCell

#pragma mark - Class Methods

/**
 Cell height
 */
+ (CGFloat)cellHeight
{
    return 238.0f;
}

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier
{
    return BOTOrderStatusCollectionViewCellReuseIdentifier;
}

#pragma mark - Init / Layout

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
    // Nada for now
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Vairous Stylings
    self.contentView.backgroundColor = [UIColor clearColor];
    self.trackShipmentBottomButton.backgroundColor = [UIColor whiteColor];
    
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = NO;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
    self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    
    // Add Targets
    [self.viewAllButton addTarget:self action:@selector(viewAllWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.trackShipmentBottomButton addTarget:self action:@selector(trackShipmentBottomButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ATLMessagePresentingConformance

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *data = DataForMessagePart(part);
    BOTShipment *shipment = [BOTShipment shipmentWithData:data];
    self.shipment = shipment;
}

#pragma mark - Shipment Setter

- (void)setShipment:(BOTShipment *)shipment
{
    if (_shipment != shipment) {
        _shipment = shipment;
        
        // Set Shipment Info
        self.shipmentStatusLabel.text = shipment.status;
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss zzz yyyy";
        NSDate *date = [formatter dateFromString:shipment.deliveryDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE d MMM yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        self.estimatedDeliveryDateLabel.text = dateString;
        
        self.productTitleLabel.text = shipment.heroProductName;
        if ([shipment.boxCount integerValue] > 1) {
            NSString *moreItemsText  = [NSString stringWithFormat:@"+ %li More Items", ([shipment.boxCount integerValue] - 1)];
            self.moreItemsLabel.text = moreItemsText;
        } else {
            self.moreItemsLabel.text = @"No Additional Items";
        }
        [self setProductImage:shipment.heroProductImageURL];
        [self setOrderStatusTextAndGlyphWithStatus:shipment.status];
        [self setNeedsLayout];
    }
}

- (void)setOrder:(BOTOrder *)order
{
    _order = order;
}

- (void)setOrderStatusTextAndGlyphWithStatus:(NSString *)shipmentStatus
{
    NSString *lCaseShipmentStatus = [shipmentStatus lowercaseString];
    if ([lCaseShipmentStatus isEqualToString:@"processing"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"processing" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:blueColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"in transit"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"intransit" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:greenColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"delivered"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"delivered" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:greenColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"ready for pickup"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"readyforpickup" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:greenColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"did not pick up"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"didnotpickup" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:grayColorCode];
    } else {
        self.shipmentStatusImageView.image = nil;
    }
    self.shipmentStatusLabel.text = shipmentStatus;
}

- (void)setProductImage:(NSString *)productImageURL
{
    if (productImageURL) {
        NSURL *picURL = [NSURL URLWithString:productImageURL];
        __weak typeof(self) wSelf = self;
        [self.productImageView sd_setImageWithURL:picURL
                              placeholderImage:[UIImage imageNamed:@"GhostImage" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         if (image && cacheType == SDImageCacheTypeNone) {
                                             [UIView animateWithDuration:0.3
                                                              animations:^{
                                                                  wSelf.productImageView.alpha = 1.0;
                                                              }];
                                         }
                                     }];
    } else {
        [self.productImageView setImage:[UIImage imageNamed:@"GhostImage" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil]];
    }

}

#pragma mark - Target Action Responders

- (void)viewAllWasTapped:(UIButton *)viewAllButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTViewAllOrdersButtonTapNotification object:self.shipment];
}

- (void)trackShipmentBottomButtonWasTapped:(UIButton *)trackShipmentBottomButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTTrackOrderShipmentButtonTapNotification object:self.shipment];
}

@end
