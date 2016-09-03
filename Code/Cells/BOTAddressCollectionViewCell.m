//
//  STAddressCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTAddressCollectionViewCell.h"
#import "BOTUtilities.h"
#import "BOTAddress.h"

NSString *const BOTAddressCollectionViewCellTitle= @"Address Cell";
NSString *const BOTAddressCollectionViewCellMimeType = @"json/address";
NSString *const BOTAddressCollectionViewCellReuseIdentifier = @"STAddressCollectionViewCellReuseIdentifier";

@interface BOTAddressCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *addressName;
@property (strong, nonatomic) IBOutlet UILabel *addressStreet;
@property (strong, nonatomic) IBOutlet UILabel *addressCity;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation BOTAddressCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.view.layer.cornerRadius = 4.0f;
    self.view.layer.masksToBounds = NO;
    self.view.layer.borderWidth = 1.0f;
    self.view.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.view.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 3;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.view.userInteractionEnabled = NO;
    
    self.mapView.scrollEnabled = NO;
}

+ (NSString *)reuseIdentifier
{
    return BOTAddressCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 250;
}

#pragma mark - ATLMessagePresenting

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSDictionary *data = DataForMessagePart(part);
    BOTAddress *address = [BOTAddress addressWithData:data];
    self.addressName.text = [NSString stringWithFormat:@"%@ %@", address.firstName, address.lastName];
    self.addressStreet.text = address.street;
    self.addressCity.text = [NSString stringWithFormat:@"%@, %@ %@", address.city, address.state, address.zip];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(address.lattitude, address.longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [annotation setTitle:@"Kevin"]; //You can set the subtitle too
    [self.mapView addAnnotation:annotation];
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
