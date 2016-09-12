//
//  BOTShipmentTrackingCollectionViewCell.m
//  Pods
//
//  Created by Jayashree on 19/08/16.
//
//

#import "BOTShipmentTrackingCollectionViewCell.h"
#import "ATLMessagingUtilities.h"
#import "BOTCircleImageView.h"
#import "BOTUtilities.h"

NSString *const BOTShipmentTrackingCollectionViewCellReuseIdentifier = @"BOTShipmentTrackingCollectionViewCellReuseIdentifier";

@interface BOTShipmentTrackingCollectionViewCell ()

@property (weak, nonatomic) IBOutlet BOTCellContainerView *cellContainerView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;

// State Image Views
@property (strong, nonatomic) IBOutlet BOTCircleImageView *placedImageView;
@property (strong, nonatomic) IBOutlet BOTCircleImageView *shippedImageView;
@property (strong, nonatomic) IBOutlet BOTCircleImageView *outForDeliveryImageView;
@property (strong, nonatomic) IBOutlet BOTCircleImageView *completeImageView;

// State Labels
@property (strong, nonatomic) IBOutlet UILabel *placedLabel;
@property (strong, nonatomic) IBOutlet UILabel *shippedLabel;
@property (strong, nonatomic) IBOutlet UILabel *outForDeliveryLabel;
@property (strong, nonatomic) IBOutlet UILabel *completedLabel;

@property (strong, nonatomic) IBOutlet UIView *lineNumber1;
@property (strong, nonatomic) IBOutlet UIView *lineNumber2;
@property (strong, nonatomic) IBOutlet UIView *lineNumber3;

@end

@implementation BOTShipmentTrackingCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // State Config
    self.placedImageView.layer.borderWidth = 4;
    self.placedImageView.layer.borderColor = BOTBlueColor().CGColor;
    self.placedLabel.text = @"PLACED";
    
    self.shippedImageView.layer.borderWidth = 4;
    self.shippedImageView.layer.borderColor = BOTBlueColor().CGColor;
    self.shippedImageView.layer.masksToBounds = YES;
    self.shippedLabel.text = @"SHIPPED";
    
    self.outForDeliveryImageView.layer.borderWidth = 4;
    self.outForDeliveryImageView.layer.borderColor = BOTBlueColor().CGColor;
    self.outForDeliveryLabel.text = @"OUT FOR DELIVERY";
    
    self.completeImageView.layer.borderWidth = 4;
    self.completeImageView.layer.borderColor = BOTBlueColor().CGColor;
    self.completedLabel.text = @"COMPLETE";
    
    self.lineNumber1.backgroundColor = BOTBlueColor();
    self.lineNumber2.backgroundColor = BOTBlueColor();
    self.lineNumber3.backgroundColor = BOTBlueColor();
    
    self.cellContainerView.layer.cornerRadius = 4.0f;
    self.cellContainerView.layer.masksToBounds = NO;
    self.cellContainerView.layer.borderWidth = 1.0f;
    self.cellContainerView.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.cellContainerView.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.cellContainerView.layer.shadowOpacity = 0.5;
    self.cellContainerView.layer.shadowRadius = 3;
    self.cellContainerView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.cellContainerView.userInteractionEnabled = NO;
    
    self.orderNumberLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    self.orderDetailLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightThin];
}

+ (NSString *)reuseIdentifier
{
    return BOTShipmentTrackingCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 180;
}

- (void)setShipment:(BOTShipment *)shipment
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss zzz yyyy";
    NSDate *date = [formatter dateFromString:shipment.deliveryDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *orderNumberText = [NSString stringWithFormat:@"Order Number: %@", shipment.order.orderNumber];
    self.orderNumberLabel.attributedText = [self attributedTextForOrderNumber:orderNumberText];
    NSString *boxCount = [NSString stringWithFormat:@"%@",shipment.boxCount];
    if([boxCount isEqual:@"1"])
        self.orderDetailLabel.text = [NSString stringWithFormat:@"%@ Box | ETA %@", shipment.boxCount, dateString];
    else
        self.orderDetailLabel.text = [NSString stringWithFormat:@"%@ Boxes | ETA %@", shipment.boxCount, dateString];
    
    if([shipment.status isEqual: @"Processing"]) {
        self.placedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        
    }else if ([shipment.status isEqual:@"In-Transit"]) {
        self.lineNumber1.backgroundColor = BOTBlueColor();
        self.placedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shippedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        
    }else if ([shipment.status isEqual:@"Out for delivery"] || [shipment.status isEqual:@"Shipped"]) {
        self.lineNumber1.backgroundColor = BOTBlueColor();
        self.lineNumber2.backgroundColor = BOTBlueColor();
        self.placedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shippedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.outForDeliveryImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        
    }else if ([shipment.status isEqual:@"Delivered"]) {
        self.lineNumber1.backgroundColor = BOTBlueColor();
        self.lineNumber2.backgroundColor = BOTBlueColor();
        self.lineNumber3.backgroundColor = BOTBlueColor();
        self.placedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.shippedImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.outForDeliveryImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
        self.completeImageView.image = [UIImage imageNamed:@"tracking" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil];
    }

}

#pragma mark - Attibuted Text

- (NSAttributedString *)attributedTextForOrderNumber:(NSString *)orderNumberText
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:orderNumberText];
    [text setAttributes:@{NSFontAttributeName:self.orderNumberLabel.font,
                          NSForegroundColorAttributeName: BOTBlueColor(),
                          NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot)} range:NSMakeRange(14, text.length - 14)];
    return text;
}

@end
