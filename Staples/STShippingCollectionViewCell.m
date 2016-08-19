//
//  STShippingCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STShippingCollectionViewCell.h"

NSString *const STAddressCollectionViewCellReuseIdentifier = @"STAddressCollectionViewCellReuseIdentifier";

@implementation STShippingCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (NSString *)reuseIdentifier
{
    return STAddressCollectionViewCellReuseIdentifier;
}

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:nil];
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // Nothing to do.
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // Nothing to do.
}

@end
