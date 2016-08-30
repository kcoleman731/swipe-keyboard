//
//  STItemCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTItemCollectionViewCell.h"
#import "BOTUtilities.h"
#import "UIImageView+WebCache.h"

NSString *const BOTItemCollectionViewCellReuseIdentifier = @"BOTItemCollectionViewCellReuseIdentifier";

@interface BOTItemCollectionViewCell ()

@property (nonatomic, strong) BOTProductItem *item;

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *deliveryLabel;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;

@end

@implementation BOTItemCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureUI];
}

- (void)configureUI
{
    self.clipsToBounds = NO;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10.0;
    self.layer.borderColor = BOTLightGrayColor().CGColor;
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 2;
    self.clipsToBounds = YES;
}

+ (NSString *)reuseIdentifier
{
    return BOTItemCollectionViewCellReuseIdentifier;
}

- (void)setProductItem:(BOTProductItem *)item
{
    self.item = item;
    
    // Set UI
    self.descriptionLabel.text = item.name;
    self.priceLabel.text = item.price.price;
    self.deliveryLabel.text = @"Pick Up Today";
    [self setProductImageURL:item.imageURL];
}

/**
 *  Setter for the product pic. Uses caching + effects for fade in for loading photos
 *
 *  @param imageURL PicURL
 */
- (void)setProductImageURL:(NSString *)imageURL
{
    if (imageURL) {
        NSURL *picURL = [NSURL URLWithString:imageURL];
        __weak typeof(self) wSelf = self;
        [self.itemImageView sd_setImageWithURL:picURL
                                 placeholderImage:nil
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                            if (image && cacheType == SDImageCacheTypeNone) {
                                                [UIView animateWithDuration:0.3
                                                                 animations:^{
                                                                     wSelf.itemImageView.alpha = 1.0;
                                                                 }];
                                            }
                                        }];
    } else {
        [self.itemImageView setImage:nil];
    }
}

@end
