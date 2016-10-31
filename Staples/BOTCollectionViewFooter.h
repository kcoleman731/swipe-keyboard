//
//  BOTCollectionViewFooter.h
//  Staples
//
//  Created by Kevin Coleman on 10/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>

extern NSString *const BOTCollectionViewFooterItemSelectedNotification;
extern NSString *const BOTCollectionViewFooterReuseIdentifier;

@interface BOTCollectionViewFooter : UICollectionReusableView

@property (nonatomic) LYRMessage *message;

+ (NSString *)reuseIdentifier;

- (void)updateWithSelectionTitle:(NSArray *)selectionTitles;

- (void)updateWithAttributedStringForRecipientStatus:(nullable NSAttributedString *)recipientStatus;

+ (CGFloat)footerHeightWithRecipientStatus:(nullable NSAttributedString *)recipientStatus  clustered:(BOOL)clustered;

@end
