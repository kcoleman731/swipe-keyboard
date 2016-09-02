//
//  BOTReceiptCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReceiptCollectionViewCell.h"
#import "BOTUtilities.h"
#import "BOTReceipt.h"

NSString *const BOTShippingCollectionViewCellTitle = @"Shipping Cell";
NSString *const BOTReceiptCollectionViewCellReuseIdentifier = @"BOTReceiptCollectionViewCellReuseIdentifier";

@interface BOTReceiptCollectionViewCell ()

@property (strong, nonatomic) IBOutlet BOTCellContainerView *cellContainerView;
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) IBOutlet UIView *seperator;
@property (strong, nonatomic) IBOutlet UILabel *deliverToLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressStreetLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressCityLabel;

@end

@implementation BOTReceiptCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cellContainerView.layer.borderColor = BOTLightGrayColor().CGColor;
    self.cellContainerView.layer.cornerRadius = 4;
    self.cellContainerView.layer.borderWidth = 2;
    self.cellContainerView.clipsToBounds = YES;
    self.seperator.backgroundColor = BOTLightGrayColor();
    
    self.deliverToLabel.text = @"Deliver To:";
}

+ (NSString *)reuseIdentifier
{
    return BOTReceiptCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 240;
}

#pragma mark - ATLMessagePresenting

NSString *const BOTMMessagePartShipmentTrackingListKey = @"shippmentTrackingList";

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *data = DataForMessagePart(part);
    
    BOTReceipt *receipt = [BOTReceipt receiptWithData:data];
    NSString *orderNumberString = [NSString stringWithFormat:@"Order Number: %@", receipt.orderNumber];
    self.orderNumberLabel.attributedText = [self attributedTextForOrderNumber:orderNumberString];
    self.priceLabel.text = receipt.price;
    self.itemLabel.text = [NSString stringWithFormat:@"%@ Item | ETA: %@", receipt.itemsCount, receipt.eta];
    self.addressNameLabel.text = [NSString stringWithFormat:@"%@ %@", receipt.address.firstName, receipt.address.lastName];
    self.addressStreetLabel.text = receipt.address.street;
    self.addressCityLabel.text = [NSString stringWithFormat:@"%@, %@ %@", receipt.address.city, receipt.address.state, receipt.address.zip];
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
