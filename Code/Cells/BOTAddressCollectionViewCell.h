//
//  STAddressCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Atlas/Atlas.h>

extern NSString *const BOTAddressCollectionViewCellTitle;
extern NSString *const BOTAddressCollectionViewCellMimeType;

@interface BOTAddressCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UILabel *addressName;

@property (strong, nonatomic) IBOutlet UILabel *addressStreet;

@property (strong, nonatomic) IBOutlet UILabel *addressCity;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

@end
