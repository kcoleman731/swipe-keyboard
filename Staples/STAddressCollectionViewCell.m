//
//  STAddressCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STAddressCollectionViewCell.h"
#import "STUtilities.h"

NSString *const STAddressName = @"STAddressName";
NSString *const STAddressStreet = @"STAddressStreet";
NSString *const STAddressCity = @"STAddressCity";
NSString *const STAddressLon = @"STAddressLon";
NSString *const STAddressLat = @"STAddressLat";

NSString *const STAddressCollectionViewCellReuseIdentifier = @"STAddressCollectionViewCellReuseIdentifier";

@implementation STAddressCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.view.layer.borderColor = STLightGrayColor().CGColor;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderWidth = 1;
    self.view.layer.shadowRadius = 2;
    self.view.clipsToBounds = YES;
    
    self.mapView.scrollEnabled = NO;
}

+ (NSString *)reuseIdentifier
{
    return STAddressCollectionViewCellReuseIdentifier;
}

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:nil];
    self.addressName.text = data[STAddressName];
    self.addressStreet.text = data[STAddressStreet];
    self.addressCity.text = data[STAddressCity];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.79154, -122.42211);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region];
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
