//
//  STShippingCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STShippingCollectionViewCell.h"
#import "STUtilities.h"

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

#pragma mark - ATLMessagePresenting

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:nil];
    
    self.orderNumberLabel.attributedText = [self attributedTextForOrderNumber:data[STOrderNumberKey]];
    self.priceLabel.text = data[STOrderPriceKey];
    self.itemLabel.text = data[STOrderItemKey];
    self.addressNameLabel.text = data[STAddressName];
    self.addressStreetLabel.text = data[STAddressStreet];
    self.addressCityLabel.text = data[STAddressCity];
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
