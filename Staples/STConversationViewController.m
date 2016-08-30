//
//  STConversationViewController.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STConversationViewController.h"
#import "STActionInputView.h"
#import "STMultipleActionInputView.h"
#import "STMessageInputToolbar.h"
#import "STUtilities.h"
#import "STMultiSelectionBar.h"

// Cells
#import "STMultipleProductBaseCollectionViewCell.h"
#import "STAddressCollectionViewCell.h"
#import "STShippingCollectionViewCell.h"
#import "BOTRewardCollectionViewCell.h"
#import "STReorderCollectionViewCell.h"
#import "BOTActionCollectionViewCell.h"

// Models
#import "STReward.h"

@interface STConversationViewController () <STMultipleActionInputViewDelegate, ATLConversationViewControllerDataSource, ATLConversationViewControllerDelegate, STMessageInputToolbarDelegate, STMultiSelectionBarDelegate>

// Multi Selection UI and Constraint
@property (nonatomic, strong) STMultiSelectionBar *multiSelectionBar;
@property (nonnull, strong) NSLayoutConstraint *muliSelectionBarBottomConstraint;

@end

@implementation STConversationViewController

NSString *const STOptionCell = @"Option Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    [self createNewConversation];
    [self configureCollectionViewCells];
    [self layoutMultiSelectionBar];
    [self registerForNotifications];
}

- (void)registerForNotifications
{
    // Register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)configureCollectionViewCells
{
    // Product Cell
    [self.collectionView registerClass:[STMultipleProductBaseCollectionViewCell class] forCellWithReuseIdentifier:[STMultipleProductBaseCollectionViewCell reuseIdentifier]];
    
    // Action Cell
    [self registerClass:[BOTActionCollectionViewCell class] forMessageCellWithReuseIdentifier:BOTActionCollectionViewCellReuseIdentifier];
}

- (void)layoutMultiSelectionBar
{
    self.multiSelectionBar = [[STMultiSelectionBar alloc] init];
    self.multiSelectionBar.delegate = self;
    self.multiSelectionBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.multiSelectionBar setLeftSelectionTitle:@"Continue Shopping" rightSelectionTitle:@"Checkout"];
    [self.view addSubview:self.multiSelectionBar];
    [self addConstraintsToSelectionBar];
}

- (void)multipleActionInputView:(STMultipleActionInputView *)multipleActionInputView didSelectTitle:(NSString *)title
{
    NSError *error;
    NSMutableArray *messageParts;
    if ([title isEqualToString:BOTMultipleProductBaseCollectionViewCellTitle]) {
        messageParts = [self fakeProductParts];
    } else if ([title isEqualToString:STShippingCollectionViewCellTitle]) {
        messageParts = [self fakeShipmentInfo];
    } else if ([title isEqualToString:BOTRewardCollectionViewCellTitle]) {
        messageParts = [self fakeRewardInfo];
    }
    
    LYRMessage *message = [self.layerClient newMessageWithParts:messageParts options:nil error:&error];
    if (!message) {
        NSLog(@"Failed to build message with error: %@", error);
        return;
    }
   [self sendMessage:message];
    NSLog(@"Message sent!");
}

#pragma mark - ATLConversationViewControllerDelegate

- (CGFloat)conversationViewController:(ATLConversationViewController *)viewController heightForMessage:(LYRMessage *)message withCellWidth:(CGFloat)cellWidth
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:STReorderCollectionViewCellMimeType]) {
        return [STReorderCollectionViewCell cellHeight];
    }
    return 0;
}

#pragma mark - ATLConversationViewControllerDataSource

- (nullable NSString *)conversationViewController:(ATLConversationViewController *)viewController reuseIdentifierForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STReorderCollectionViewCellMimeType]) {
        return [STReorderCollectionViewCell reuseIdentifier];
    }
    return nil;
}

- (id<ATLParticipant>)conversationViewController:(ATLConversationViewController *)conversationViewController participantForIdentity:(LYRIdentity *)identity
{
    return nil;
}

- (NSAttributedString *)conversationViewController:(ATLConversationViewController *)conversationViewController attributedStringForDisplayOfDate:(NSDate *)date
{
    return [[NSAttributedString alloc] initWithString:@"Today 2:30PM"];
}

- (NSAttributedString *)conversationViewController:(ATLConversationViewController *)conversationViewController attributedStringForDisplayOfRecipientStatus:(NSDictionary *)recipientStatus
{
    return [[NSAttributedString alloc] initWithString:@"Sent"];
}

- (ATLMessageInputToolbar *)initializeMessageInputToolbar
{
    STMessageInputToolbar *toolbar = [STMessageInputToolbar new];
    toolbar.customDelegate = self;
    return toolbar;
}

#pragma mark - Message Input Toolbar Delegate 

- (void)messageInputToolbar:(STMessageInputToolbar *)messageInputToolbar didTapListAccessoryButton:(UIButton *)listAccessoryButton
{
    STMultipleActionInputView *multiOptionSelectionView = [[STMultipleActionInputView alloc] initWithSelectionTitles:[self selectionItems]];
    multiOptionSelectionView.frame = CGRectMake(0, 0, 320, 240);
    multiOptionSelectionView.delegate = self;
    messageInputToolbar.textInputView.inputView = multiOptionSelectionView;
    [messageInputToolbar.textInputView becomeFirstResponder];
}

- (void)messageInputToolbar:(STMessageInputToolbar *)messageInputToolbar multiSelectionBarTappedWithTitle:(NSString *)title
{
    //
}

#pragma mark - FAKE DATA

- (void)createNewConversation
{
    LYRConversationOptions *options = [LYRConversationOptions new];
    options.distinctByParticipants = NO;
    
    NSError *error;
    LYRConversation *conversation = [self.layerClient newConversationWithParticipants:[NSSet setWithObject:@"2"] options:options error:&error];
    if (!conversation) {
        NSLog(@"Failed to build conversatio with error: %@", error);
    }
    [self setConversation:conversation];
}

- (NSArray *)selectionItems
{
    return @[BOTMultipleProductBaseCollectionViewCellTitle, STShippingCollectionViewCellTitle , BOTRewardCollectionViewCellTitle];
}

- (NSMutableArray *)fakeRewardInfo
{
    NSMutableArray *rewards = [[NSMutableArray alloc] init];
    for (int i = 0; i < 50; i++) {
        [rewards addObject:@{
                             STRewardsUserNameKey : @"Kevin Coleman",
                             STRewardAmmountKey: @"$39.97",
                             STRewardsTotalAmountKey: @"$39.95",
                             STRewardsTypeKey: @"Redeemable",
                             STRewardsPromoImageKey: @"www.staples.com",
                             STRewardsNumberKey: @"#1234567890"
                             }];
    }
    
    NSDictionary *reward = @{@"data": @{ @"rewardslistItems" : [rewards copy]}};
    NSData *rewardData = [NSJSONSerialization dataWithJSONObject:reward options:NSJSONWritingPrettyPrinted error:nil];
    LYRMessagePart *dataPart = [LYRMessagePart messagePartWithMIMEType:STRewardMIMEType data:rewardData];
    return [NSMutableArray arrayWithObject:dataPart];
}

- (NSMutableArray *)fakeProductParts
{
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (int i = 0; i < 50; i++) {
        [products addObject:@{
                              @"quantity":@"1",
                              @"productImage":@"http://www.staples-3p.com/s7/is/image/Staples/s0071040_sc7",
                              @"skuNo":@"228445",
                              @"price":@{
                                    @"unitOfMeasure":@"Dozen",
                                    @"price":@"16.29",
                                    @"finalPrice":@"16.29",
                                    @"displayWasPricing":@"false",
                                    @"displayRegularPricing":@"false",
                                    @"buyMoreSaveMoreImage":@"",
                                },
                              @"productName":@"Paper Mate&amp;reg; FlairÂ® Felt-Tip Pens, Medium Point, Red, Dozen",
                            }];
    }
    NSDictionary *product = @{@"data": @{ @"listItems" : [products copy]}};
    NSData *productData = [NSJSONSerialization dataWithJSONObject:product options:NSJSONWritingPrettyPrinted error:nil];
    LYRMessagePart *dataPart = [LYRMessagePart messagePartWithMIMEType:STProductListMIMEType data:productData];
    
    NSDictionary *info = @{@"data": @{ @"btsItems" :  @{@"headerTitle" : @"Test Title"}}};
    NSData *infoData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];
    LYRMessagePart *infoPart = [LYRMessagePart messagePartWithMIMEType:STProductListMIMEType data:infoData];
    return [NSMutableArray arrayWithObjects:infoPart, dataPart, nil];
}

- (NSMutableArray *)fakeShipmentInfo
{
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        [products addObject:@{
                              @"boxes" : @"1",
                              @"deliveryDate" : @"Wed Aug 10 09:56:12 EDT 2016",
                              @"orderNumber" : @"9742476281",
                              @"shipmentNumber" : @"117628629",
                              @"shipmentType" : @"ISP",
                              @"status" : @"Did not pick up",
                              }];
    }
    NSDictionary *shipment = @{@"data": @{ @"shippmentTrackingList" : [products copy]}};
    NSData *shipmentData = [NSJSONSerialization dataWithJSONObject:shipment options:NSJSONWritingPrettyPrinted error:nil];
    LYRMessagePart *dataPart = [LYRMessagePart messagePartWithMIMEType:STShipmentMIMEType data:shipmentData];
    return [NSMutableArray arrayWithObject:dataPart];
}

#pragma mark - Constraints

- (void)addConstraintsToSelectionBar
{
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.multiSelectionBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44.0f];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.multiSelectionBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.multiSelectionBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0f];
    self.muliSelectionBarBottomConstraint = [NSLayoutConstraint constraintWithItem:self.multiSelectionBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0f];
    
    [self.view addConstraints:@[leading, height, trailing, self.muliSelectionBarBottomConstraint]];
}

#pragma mark - STMultiSelectionToolbar

- (void)multiSelectionBar:(STMultiSelectionBar *)bar leftSelectionHitWithTitle:(NSString *)title
{
    
}

- (void)multiSelectionBar:(STMultiSelectionBar *)bar rightSelectionHitWithTitle:(NSString *)title
{
    
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShowOrHide:(NSNotification *)note
{
    NSDictionary *info           = [note userInfo];
    NSTimeInterval duration      = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = [info[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    CGRect inputViewEndFrame     = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:duration
                          delay:0
                        options:curve | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.muliSelectionBarBottomConstraint.constant = -inputViewEndFrame.size.height;
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

@end