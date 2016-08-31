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

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeight;

@end
