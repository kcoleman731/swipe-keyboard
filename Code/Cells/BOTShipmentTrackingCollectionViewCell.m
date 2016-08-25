//
//  BOTShipmentTrackingCollectionViewCell.m
//  Pods
//
//  Created by Jayashree on 19/08/16.
//
//

#import "BOTShipmentTrackingCollectionViewCell.h"
#import "ATLMessagingUtilities.h"
#import "STUtilities.h"

NSString *const BOTShipmentTrackingCollectionViewCellReuseIdentifier = @"BOTShipmentTrackingCollectionViewCellReuseIdentifier";

@implementation BOTShipmentTrackingCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // State Config
    self.placedImageView.backgroundColor = STBlueColor();
    self.placedImageView.layer.cornerRadius = 20;
    self.placedLabel.text = @"PLACED";
    
    self.shippedImageView.backgroundColor = STBlueColor();
    self.shippedImageView.layer.cornerRadius = 20;
    self.shippedLabel.text = @"SHIPPED";
    
    self.outForDeliveryImageView.backgroundColor = STBlueColor();
    self.outForDeliveryImageView.layer.cornerRadius = 20;
    self.outForDeliveryLabel.text = @"OUT FOR DELIVERY";
    
    self.completeImageView.backgroundColor = STBlueColor();
    self.completeImageView.layer.cornerRadius = 20;
    self.completedLabel.text = @"COMPLETE";
    
    // Initialization code
    self.cellContainerView.layer.borderColor = STLightGrayColor().CGColor;
    self.cellContainerView.layer.cornerRadius = 4;
    self.cellContainerView.layer.borderWidth = 2;
    self.cellContainerView.clipsToBounds = YES;
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
    return 200;
}

- (void)setShipment:(STShipment *)shipment
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss zzz yyyy";
    NSDate *date = [formatter dateFromString:shipment.deliveryDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *orderNumberText = [NSString stringWithFormat:@"Order Number: %@", shipment.orderNumber];
    self.orderNumberLabel.attributedText = [self attributedTextForOrderNumber:orderNumberText];
    self.orderDetailLabel.text = [NSString stringWithFormat:@"%@ Boxes | ETA %@", shipment.boxCount, dateString];
}

#pragma mark - Attibuted Text

- (NSAttributedString *)attributedTextForOrderNumber:(NSString *)orderNumberText
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:orderNumberText];
    [text setAttributes:@{NSFontAttributeName:self.orderNumberLabel.font,
                          NSForegroundColorAttributeName: STBlueColor(),
                          NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot)} range:NSMakeRange(14, text.length - 14)];
    return text;
}

@end
