//
//  STShippingCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "STCellContainerView.h"
#import "STShipment.h"

extern NSString *const STShippingCollectionViewCellTitle;

@interface STShippingCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet STCellContainerView *cellContainerView;
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) IBOutlet UIView *seperator;
@property (strong, nonatomic) IBOutlet UILabel *deliverToLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressStreetLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressCityLabel;

+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

@end
