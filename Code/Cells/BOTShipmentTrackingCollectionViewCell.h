//
//  BOTShipmentTrackingCollectionViewCell.h
//  Pods
//
//  Created by Jayashree on 19/08/16.
//
//

#import <UIKit/UIKit.h>
#import "STShipment.h"
#import "STCellContainerView.h"

extern NSString *const BOTShipmentTrackingCollectionViewCellReuseIdentifier;

@interface BOTShipmentTrackingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet STCellContainerView *cellContainerView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;

// State Image Views
@property (strong, nonatomic) IBOutlet UIImageView *placedImageView;
@property (strong, nonatomic) IBOutlet UIImageView *shippedImageView;
@property (strong, nonatomic) IBOutlet UIImageView *outForDeliveryImageView;
@property (strong, nonatomic) IBOutlet UIImageView *completeImageView;

// State Labels
@property (strong, nonatomic) IBOutlet UILabel *placedLabel;
@property (strong, nonatomic) IBOutlet UILabel *shippedLabel;
@property (strong, nonatomic) IBOutlet UILabel *outForDeliveryLabel;
@property (strong, nonatomic) IBOutlet UILabel *completedLabel;

@property (strong, nonatomic) IBOutlet UIImageView *lineNumber1;
@property (strong, nonatomic) IBOutlet UIImageView *lineNumber2;
@property (strong, nonatomic) IBOutlet UIImageView *lineNumber3;

/**
 *  Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 *  Product Items Setter
 */
- (void)setShipment:(STShipment *)shipment;

/**
 *  Cell Height
 */
+ (CGFloat)cellHeight;

@end
