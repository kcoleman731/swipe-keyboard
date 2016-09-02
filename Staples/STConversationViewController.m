//
//  STConversationViewController.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STConversationViewController.h"
#import "BOTActionInputView.h"
#import "BOTMultipleActionInputView.h"
#import "BOTMessageInputToolbar.h"
#import "BOTUtilities.h"
#import "BOTMultiSelectionBar.h"
#import "BOTMessageInputToolbar.h"
#import "BOTShipment.h"

// Cells
#import "BOTMultipleProductBaseCollectionViewCell.h"
#import "BOTProductCollectionViewCell.h"
#import "BOTAddressCollectionViewCell.h"
#import "BOTReceiptCollectionViewCell.h"
#import "BOTReorderCollectionViewCell.h"
#import "BOTShipmentTrackingCollectionViewCell.h"
#import "BOTRewardCollectionViewCell.h"
//#import "BOTReturnCollectionViewCell.h"
#import "BOTActionCollectionViewCell.h"

// Models
#import "BOTReward.h"
#import "BOTAddress.h"
#import "BOTReceipt.h"
#import "BOTShipment.h"
#import "BOTReward.h"
#import "BOTOrder.h"

@interface STConversationViewController () <BOTMultipleActionInputViewDelegate, ATLConversationViewControllerDataSource, ATLConversationViewControllerDelegate, BOTMessageInputToolbarDelegate, BOTMultiSelectionBarDelegate>

@property (nonatomic, strong) BOTMultipleActionInputView *inputView;
@property (nonatomic, strong) BOTMultiSelectionBar *multiSelectionBar;
@property (nonatomic, strong) NSLayoutConstraint *muliSelectionBarBottomConstraint;

@end

@implementation STConversationViewController

NSString *const STOptionCell = @"Option Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    self.shouldDisplayAvatarItemForOneOtherParticipant = NO;

    [self createNewConversation];
    [self configureCollectionViewCells];
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
    [self.collectionView registerClass:[BOTMultipleProductBaseCollectionViewCell class] forCellWithReuseIdentifier:[BOTMultipleProductBaseCollectionViewCell reuseIdentifier]];
    
    // Receipt Cell
    UINib *receiptCell = [UINib nibWithNibName:@"BOTReceiptCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:receiptCell forCellWithReuseIdentifier:[BOTReceiptCollectionViewCell reuseIdentifier]];
    
    // Address Cell
    UINib *addressCell = [UINib nibWithNibName:@"BOTAddressCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:addressCell forCellWithReuseIdentifier:[BOTAddressCollectionViewCell reuseIdentifier]];
    
    // Action Cell
    [self registerClass:[BOTActionCollectionViewCell class] forMessageCellWithReuseIdentifier:BOTActionCollectionViewCellReuseIdentifier];
}

- (void)layoutMultiSelectionBar
{
    self.multiSelectionBar = [[BOTMultiSelectionBar alloc] init];
    self.multiSelectionBar.delegate = self;
    self.multiSelectionBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.multiSelectionBar setLeftSelectionTitle:@"Continue Shopping" rightSelectionTitle:@"Checkout"];
    [self.view addSubview:self.multiSelectionBar];
    [self addConstraintsToSelectionBar];
}

- (void)multipleActionInputView:(BOTMultipleActionInputView *)multipleActionInputView didSelectTitle:(NSString *)title
{
    if ([title isEqualToString:BOTOptionTrackMyShipment]) {
        // messageParts = [self fakeProductParts];
    } else if ([title isEqualToString:BOTOptionOrderNewSupplies]) {
        //[self.inputView setSelectionTitles:[self orderSupplySelectionItems]];
    } else if ([title isEqualToString:BOTOptionReorderLastShipment]) {
        // messageParts = [self fakeRewardInfo];
    } else if ([title isEqualToString:BOTOptionScanSchoolSuppliesList]) {
        
    }
    
    NSError *error;
    LYRMessagePart *part = [LYRMessagePart messagePartWithText:title];
    LYRMessage *message = [self.layerClient newMessageWithParts:@[part] options:nil error:&error];
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
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTAddressMIMEType]) {
        return [BOTAddressCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTReceiptMIMEType]) {
        return [BOTReceiptCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTReorderCollectionViewCellMimeType]) {
        return [BOTReorderCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTReorderMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTReturnMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    }
    return 0;
}

#pragma mark - ATLConversationViewControllerDataSource

- (nullable NSString *)conversationViewController:(ATLConversationViewController *)viewController reuseIdentifierForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTAddressMIMEType]) {
        return [BOTAddressCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReceiptMIMEType]) {
        return [BOTReceiptCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        return [BOTMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReorderCollectionViewCellMimeType]) {
        return [BOTReorderCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReorderMIMEType]) {
        return [BOTReorderCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReturnMIMEType]) {
        return [BOTReorderCollectionViewCell reuseIdentifier];
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
    BOTMessageInputToolbar *toolbar = [BOTMessageInputToolbar new];
    toolbar.customDelegate = self;
    return toolbar;
}

#pragma mark - Message Input Toolbar Delegate 

- (void)messageInputToolbar:(BOTMessageInputToolbar *)messageInputToolbar didTapListAccessoryButton:(UIButton *)listAccessoryButton
{
    self.inputView = [[BOTMultipleActionInputView alloc] initWithSelectionTitles:[self selectionItems]];
    self.inputView.frame = CGRectMake(0, 0, 320, 240);
    self.inputView.delegate = self;
    messageInputToolbar.textInputView.inputView = self.inputView;
    [messageInputToolbar.textInputView becomeFirstResponder];
}

- (void)messageInputToolbar:(BOTMessageInputToolbar *)messageInputToolbar multiSelectionBarTappedWithTitle:(NSString *)title
{
    //
}

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

- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar leftSelectionHitWithTitle:(NSString *)title
{
    
}

- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar rightSelectionHitWithTitle:(NSString *)title
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

#pragma mark - FAKE DATA

- (NSArray *)selectionItems
{
    return @[BOTOptionTrackMyShipment, BOTOptionOrderNewSupplies, BOTOptionReorderLastShipment, BOTOptionScanSchoolSuppliesList, BOTOptionReturnItems, BOTOptionViewReceipt, BOTOptionViewMyRewards, BOTOptionViewMyAddress];
}

- (NSArray *)orderSupplySelectionItems
{
    return @[BOTOptionPaper, BOTOptionRedSharpies, BOTOptionJournals, BOTOptionStaplers];
}

@end