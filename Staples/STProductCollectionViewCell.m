//
//  STMultipleProductsCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STProductCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "EDColor.h"
#import "STUtilities.h"

// Cell ID
NSString *const STProductCollectionViewCellId = @"STProductCollectionViewCellId";

@interface STProductCollectionViewCell ()

// Model
@property (nonatomic, strong) STProductItem *item;

// UI
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

IB_DESIGNABLE

@implementation STProductCollectionViewCell

#pragma mark - Layout / Init

- (void)awakeFromNib
{
    [self configureUI];
    [self configureAddButton];
}

- (void)configureUI
{
    self.clipsToBounds = NO;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10.0;
    self.layer.borderColor = STLightGrayColor().CGColor;
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 2;
    self.clipsToBounds = YES;
    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowRadius = 2.0;
//    self.layer.shadowOpacity = 0.4;
//    self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
}

- (void)configureAddButton
{
    self.addToCartButton.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.addToCartButton.layer.shadowOpacity = 0.3f;
    self.addToCartButton.layer.shadowRadius = 1.0;
    self.addToCartButton.layer.shadowOffset = CGSizeMake(2.0, 2.0);
}

+ (NSString *)reuseIdentifier
{
    return STProductCollectionViewCellId;
}

#pragma mark - Product Setter

// Setter for the product
- (void)setProductItem:(STProductItem *)item
{
    self.item = item;
    
    // Set UI
    self.productDescriptionLabel.text = item.title;
    self.priceLabel.text = item.price;
    [self setProductImageURL:item.picURL];
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
        [self.productImageView sd_setImageWithURL:picURL
                                 placeholderImage:nil
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                            if (image && cacheType == SDImageCacheTypeNone) {
                                                [UIView animateWithDuration:0.3
                                                                 animations:^{
                                                                     wSelf.productImageView.alpha = 1.0;
                                                                 }];
                                            }
                                        }];
    } else {
        [self.productImageView setImage:nil];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    /**
     *  Draw Triangle
     */
    const CGFloat rightTriangleLegWidth = 32.0;
    
    // Generate ctrl pts
    CGPoint firstPoint = CGPointMake(rect.origin.x + rect.size.width, 0.0);
    CGPoint secondPoint = CGPointMake(firstPoint.x - rightTriangleLegWidth, firstPoint.y);
    CGPoint thirdPoint = CGPointMake(firstPoint.x, firstPoint.y + rightTriangleLegWidth);
    
    // Gen path
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    [bezPath moveToPoint:firstPoint];
    [bezPath addLineToPoint:secondPoint];
    [bezPath addLineToPoint:thirdPoint];
    [bezPath closePath];
    
    // Set Color
    UIColor *lavaRed = [UIColor colorWithHexString:@"CE0B24"];
    [lavaRed setFill];
    
    // Fill
    [bezPath fill];
    
    /**
     *  Draw Text
     */
    
    // Attrs
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    UIColor *textColor = [UIColor whiteColor];
    NSDictionary *stringAttrs = @{NSFontAttributeName : font, NSForegroundColorAttributeName : textColor};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"i" attributes:stringAttrs];
    
    // Draw layout
    CGPoint textPoint = CGPointMake(rect.size.width - 12, rect.origin.y + 3);
    [attrStr drawAtPoint:textPoint];
}

@end
