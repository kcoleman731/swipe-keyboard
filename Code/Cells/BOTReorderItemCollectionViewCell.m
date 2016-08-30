//
//  STReorderItemCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReorderItemCollectionViewCell.h"
#import "UIImageView+WebCache.h"

NSString *const BOTReorderItemCollectionViewCellReuseIdentifier = @"BOTReorderItemCollectionViewCellReuseIdentifier";

@interface BOTReorderItemCollectionViewCell ()

@property (nonatomic, strong) BOTProductItem *item;

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemCount;

@end

@implementation BOTReorderItemCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return BOTReorderItemCollectionViewCellReuseIdentifier;
}

- (void)setProductItem:(BOTProductItem *)item
{
    _item = item;
    self.itemCount.text = item.quatity;
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
