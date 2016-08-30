//
//  STShippingCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTShippingCollectionViewCell.h"
#import "BOTUtilities.h"

NSString *const BOTShippingCollectionViewCellTitle = @"Shipping Cell";
NSString *const BOTShippingCollectionViewCellReuseIdentifier = @"STShippingCollectionViewCellReuseIdentifier";

@implementation BOTShippingCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView.layer.borderColor = BOTLightGrayColor().CGColor;
    self.backgroundView.layer.cornerRadius = 4;
    self.backgroundView.layer.borderWidth = 2;
    self.backgroundView.clipsToBounds = YES;
    self.seperator.backgroundColor = BOTLightGrayColor();
    
    self.deliverToLabel.text = @"Deliver To:";
    self.deliverToLabel.font = [UIFont boldSystemFontOfSize:12];
    self.priceLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightThin];
    self.itemLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
}

+ (NSString *)reuseIdentifier
{
    return BOTShippingCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 220;
}

#pragma mark - ATLMessagePresenting

NSString *const BOTMMessagePartShipmentTrackingListKey = @"shippmentTrackingList";

- (void)presentMessage:(LYRMessage *)message
{
    
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
                          NSForegroundColorAttributeName: BOTBlueColor(),
                          NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot)} range:NSMakeRange(14, text.length - 14)];
    return text;
}

@end
