//
//  BOTProductCollectionViewCell
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTProductCollectionViewCell.h"
#import "BOTUtilities.h"
#import "UIImageView+WebCache.h"

NSString *const BOTBackToSchoolViewCartButtonTappedNotification = @"BOTBackToSchoolViewCartButtonTappedNotification";
NSString *const BOTProductCollectionViewCellReuseIdentifier = @"BOTProductCollectionViewCellReuseIdentifier";

@interface BOTProductCollectionViewCell ()

@property (nonatomic, strong) BOTProduct *item;

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *deliveryLabel;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;

@end

@implementation BOTProductCollectionViewCell

CGFloat const BOTProductCollectionViewCellHeight = 220;
CGFloat const BOTAddToCartButtonHeight = 42;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureUI];
}

- (void)configureUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = NO;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
    self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.userInteractionEnabled = YES;
    
    self.addToCartButton = [UIButton new];
    self.addToCartButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addToCartButton.layer.cornerRadius = 4;
    self.addToCartButton.layer.borderColor = BOTLightGrayColor().CGColor;
    self.addToCartButton.layer.borderWidth = 2;
    
    [self.addToCartButton setTitle:@"Add to cart" forState:UIControlStateNormal];
    [self.addToCartButton setTitleColor:BOTBlueColor() forState:UIControlStateNormal];
    [self.addToCartButton addTarget:self action:@selector(viewInCartButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addToCartButton];
    [self configureAddToCardButtonConstraints];
}

+ (CGFloat)cellHeightWithButton:(BOOL)button
{
    return button ? BOTProductCollectionViewCellHeight + BOTAddToCartButtonHeight : BOTProductCollectionViewCellHeight;
}

+ (NSString *)reuseIdentifier
{
    return BOTProductCollectionViewCellReuseIdentifier;
}

- (void)setProductItem:(BOTProduct *)item showAddToCartButton:(BOOL)showAddToCartButton
{
    self.item = item;
    showAddToCartButton = NO;
    // Set UI
    self.descriptionLabel.text = item.name;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", item.price.finalPrice];
    self.deliveryLabel.text = @"Pick Up Today";
    self.deliveryLabel.hidden = YES;
    [self setProductImageURL:item.imageURL];
    
    if(showAddToCartButton){
        self.addToCartButton.hidden = NO;
    }else{
        self.addToCartButton.hidden = YES;
    }
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
                              placeholderImage:[UIImage imageNamed:@"GhostImage" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         if (image && cacheType == SDImageCacheTypeNone) {
                                             [UIView animateWithDuration:0.3
                                                              animations:^{
                                                                  wSelf.itemImageView.alpha = 1.0;
                                                              }];
                                         }
                                     }];
    } else {
        [self.itemImageView setImage:[UIImage imageNamed:@"GhostImage" inBundle:StaplesUIBundle() compatibleWithTraitCollection:nil]];
    }
}

- (void)configureAddToCardButtonConstraints
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addToCartButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addToCartButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addToCartButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addToCartButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:BOTAddToCartButtonHeight]];
}

- (void)viewInCartButtonTapped:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(productCollectionViewCellDidSelectAddToCart:)]) {
        [self.delegate productCollectionViewCellDidSelectAddToCart:self];
    }
}

@end
