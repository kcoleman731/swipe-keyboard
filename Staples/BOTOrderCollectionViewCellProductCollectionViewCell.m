//
//  BOTOrderCollectionViewCellProductCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 9/2/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderCollectionViewCellProductCollectionViewCell.h"
#import "BOTOrderCollectionViewCellProductCollectionViewCell.h"
#import "UIImageView+WebCache.h"

NSString *const BOTOrderCollectionViewCellProductCollectionViewCellReuseIdentifier = @"BOTOrderCollectionViewCellProductCollectionViewCellReuseIdentifier";

@interface BOTOrderCollectionViewCellProductCollectionViewCell ()

@property (nonatomic, strong) UIImageView *productImageView;

@end

@implementation BOTOrderCollectionViewCellProductCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return BOTOrderCollectionViewCellProductCollectionViewCellReuseIdentifier;
}

#pragma mark - Init / Layout

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor whiteColor];
    [self layoutProductImageView];
}

- (void)layoutProductImageView
{
    self.productImageView = [[UIImageView alloc] init];
    self.productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.productImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.productImageView];
    [self layoutImageView];
}

- (void)layoutImageView
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.productImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.productImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.productImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.productImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    [self addConstraints:@[top, left, bottom, right]];
}

#pragma mark - Product Setter

- (void)setProduct:(BOTProduct *)product
{
    if (_product != product) {
        _product = product;
        if (product.imageURL) {
            NSURL *picURL = [NSURL URLWithString:product.imageURL];
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
}

@end
