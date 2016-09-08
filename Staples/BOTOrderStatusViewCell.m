//
//  BOTOrderStatusViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderStatusViewCell.h"
#import "BOTOrderStatusViewCellBottomBorderView.h"
#import "BOTOrderStatusViewCellTopBorderView.h"
#import "BOTUtilities.h"
#import "UIImageView+WebCache.h"
#import "EDColor.h"

NSString *const BOTOrderStatusCollectionViewCellTitle           = @"BOTOrderStatusCollectionViewCellTitle";
NSString *const BOTOrderStatusCollectionViewCellMimeType        = @"BOTOrderStatusCollectionViewCellMimeType";
NSString *const BOTOrderStatusCollectionViewCellReuseIdentifier = @"BOTOrderStatusCollectionViewCellReuseIdentifier";

// UI Color Hexs
NSString *const blueColorCode  = @"4a90e2";
NSString *const greenColorCode = @"77a53b";
NSString *const grayColorCode  = @"9b9b9b";

@interface BOTOrderStatusViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet BOTOrderStatusViewCellBottomBorderView *trackShipmentBottomButton;
@property (weak, nonatomic) IBOutlet BOTOrderStatusViewCellTopBorderView *topBorderView;
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

@implementation BOTOrderStatusViewCell

#pragma mark - Class Methods

/**
 Cell height
 */
+ (CGFloat)cellHeight
{
    return 200.0f;
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
    self.topBorderView.backgroundColor = [UIColor whiteColor];
    self.trackShipmentBottomButton.backgroundColor = [UIColor whiteColor];
    
    // Style BG
    self.bgView.layer.cornerRadius = 4.0f;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1.0f;
    self.bgView.layer.borderColor = BOTLightGrayColor().CGColor;
    self.bgView.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 3;
    self.bgView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.bgView.userInteractionEnabled = NO;
    
    // kill shadows
    self.productImageView.layer.shadowRadius = 0.0;
    self.trackShipmentBottomButton.imageView.layer.shadowRadius = 0.0;
    
    // Add Targets
    [self.viewAllButton addTarget:self action:@selector(viewAllWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.trackShipmentBottomButton addTarget:self action:@selector(trackMyShipmentWasTapped:) forControlEvents:UIControlEventTouchUpInside];
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
        self.estimatedDeliveryDateLabel.text = shipment.deliveryDate;
        [self setItemLabelsWithOrders:shipment.order.items];
        [self setOrderStatusTextAndGlyphWithStatus:shipment.status];
    }
}

- (void)setItemLabelsWithOrders:(NSArray <BOTProduct *> *)items
{
    // Fill the order details w/ the shipment's order
    if (items) {
        BOTProduct *product         = [items firstObject];
        self.productTitleLabel.text = product.name;
        [self setProductImage:product.imageURL];
        
        // More items label
        if (items.count > 1) {
            NSString *moreItemsText  = [NSString stringWithFormat:@"+ %i More Items", (int)items.count];
            self.moreItemsLabel.text = moreItemsText;
        } else {
            self.moreItemsLabel.text = @"No Additional Items";
        }
        [self setNeedsLayout];
    } else {
        self.productImageView.image = nil;
        self.productTitleLabel.text = @"No Products Found";
        self.moreItemsLabel.text    = @"";
    }
}

- (void)setOrderStatusTextAndGlyphWithStatus:(NSString *)shipmentStatus
{
    NSString *lCaseShipmentStatus = [shipmentStatus lowercaseString];
    if ([lCaseShipmentStatus isEqualToString:@"processing"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"processing"];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:blueColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"in transit"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"intransit"];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:greenColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"delivered"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"delivered"];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:greenColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"ready for pickup"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"readyforpickup"];
        self.shipmentStatusLabel.textColor = [UIColor colorWithHexString:greenColorCode];
    } else if ([lCaseShipmentStatus isEqualToString:@"did not pick up"]) {
        self.shipmentStatusImageView.image = [UIImage imageNamed:@"didnotpickup"];
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
                              placeholderImage:nil
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         if (image && cacheType == SDImageCacheTypeNone) {
                                             [UIView animateWithDuration:0.3
                                                              animations:^{
                                                                  wSelf.productImageView.alpha = 1.0;
                                                              }];
                                         }
                                     }];
    } else {
        [self.productImageView setImage:nil];
    }
}

#pragma mark - Target Action Responders

- (void)viewAllWasTapped:(UIButton *)btn
{
    [self.delegate orderStatusCell:self viewAllWasTappedWithShipment:self.shipment];
}

- (void)trackMyShipmentWasTapped:(UIButton *)btn
{
    [self.delegate orderStatusCell:self trackShipmentWasTappedWithShipment:self.shipment];
}

@end
