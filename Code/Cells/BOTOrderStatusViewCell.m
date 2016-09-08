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

NSString *const BOTOrderStatusCollectionViewCellTitle           = @"BOTOrderStatusCollectionViewCellTitle";
NSString *const BOTOrderStatusCollectionViewCellMimeType        = @"BOTOrderStatusCollectionViewCellMimeType";
NSString *const BOTOrderStatusCollectionViewCellReuseIdentifier = @"BOTOrderStatusCollectionViewCellReuseIdentifier";
NSString *const BOTTrackOrderShipmentButtonTapNotification      = @"BOTTrackOrderShipmentButtonTapNotification";
NSString *const BOTViewAllOrdersButtonTapNotification           = @"BOTViewAllOrdersButtonTapNotification";

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

@end

@implementation BOTOrderStatusViewCell

#pragma mark - Class Methods

/**
 Cell height
 */
+ (CGFloat)cellHeight
{
    return 237.0f;
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

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.topBorderView.backgroundColor = [UIColor whiteColor];
    self.trackShipmentBottomButton.backgroundColor = [UIColor whiteColor];
    
    self.bgView.layer.cornerRadius = 4.0f;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1.0f;
    self.bgView.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.bgView.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 3;
    self.bgView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.bgView.userInteractionEnabled = NO;
    
    [self.viewAllButton addTarget:self action:@selector(viewAllButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.trackShipmentBottomButton addTarget:self action:@selector(trackShipmentBottomButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
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
        self.productTitleLabel.text = shipment.heroProductName;
        [self setProductImage:shipment.heroProductImageURL];
    }
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

#pragma mark - Action Handlers

- (void)viewAllButtonTapped:(UIButton *)viewAllButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTViewAllOrdersButtonTapNotification object:self.shipment];
}

- (void)trackShipmentBottomButtonTapped:(UIButton *)trackShipmentBottomButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTTrackOrderShipmentButtonTapNotification object:self.shipment];
}

@end
