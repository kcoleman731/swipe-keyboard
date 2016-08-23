//
//  STItemCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STItemCollectionViewCell.h"

@interface STItemCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *deliveryLable;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;

@end

@implementation STItemCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

@end
