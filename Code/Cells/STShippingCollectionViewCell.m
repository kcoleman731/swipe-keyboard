//
//  STShippingCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STShippingCollectionViewCell.h"
#import "STUtilities.h"

NSString *const STShippingCollectionViewCellTitle = @"Shipping Cell";
NSString *const STShippingCollectionViewCellReuseIdentifier = @"STShippingCollectionViewCellReuseIdentifier";

@implementation STShippingCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.view.layer.borderColor = STLightGrayColor().CGColor;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderWidth = 2;
    self.view.clipsToBounds = YES;
    self.seperator.backgroundColor = STLightGrayColor();
    
    self.deliverToLabel.text = @"Deliver To:";
    self.deliverToLabel.font = [UIFont boldSystemFontOfSize:12];
    self.priceLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightThin];
    self.itemLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
}

+ (NSString *)reuseIdentifier
{
    return STShippingCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 220;
}

#pragma mark - ATLMessagePresenting

NSString *const STMessagePartShipmentTrackingListKey = @"shippmentTrackingList";

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        // Handle the error;
    }
    
    NSDictionary *data = json[STMessagePartDataKey];
    NSArray *shipmentJSON = data[STMessagePartShipmentTrackingListKey];
    
    NSMutableArray *shipments = [[NSMutableArray alloc] init];
    for (NSDictionary *shipmentData in shipmentJSON) {
        STShipment *shipment = [STShipment shipmentWithData:shipmentData];
        [shipments addObject:shipment];
    }
    
    STShipment *shiment = shipments[0];
    self.orderNumberLabel.attributedText = [self attributedTextForOrderNumber:shiment.orderNumber];
//    self.priceLabel.text = // No price in body
//    self.itemLabel.text = data[STOrderItemKey]; // Create quantity and ETA label.
    self.addressNameLabel.text = @"Kevin Coleman";
    self.addressStreetLabel.text = @"1776 Sacramento Street";
    self.addressCityLabel.text = @"San Francisco, CA, 94109";
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // Nothing to do.
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // Nothing to do.
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
