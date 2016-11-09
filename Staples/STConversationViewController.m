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
#import "BOTUtilities.h"

// Cells
#import "BOTMultipleCardBaseCollectionViewCell.h"
#import "BOTProductCollectionViewCell.h"
#import "BOTAddressCollectionViewCell.h"
#import "BOTReceiptCollectionViewCell.h"
#import "BOTOrderCollectionViewCell.h"
#import "BOTOrderStatusCollectionViewCell.h"
#import "BOTRewardCollectionViewCell.h"
#import "BOTActionCollectionViewCell.h"
#import "BOTCollectionViewFooter.h"

// Models
#import "BOTReward.h"
#import "BOTAddress.h"
#import "BOTReceipt.h"
#import "BOTShipment.h"
#import "BOTReward.h"
#import "BOTOrder.h"

@interface ATLConversationViewController () <UICollectionViewDataSource>

@property (nonatomic) NSHashTable *sectionFooters;

@end

@interface STConversationViewController () <BOTMultipleActionInputViewDelegate, ATLConversationViewControllerDataSource, ATLConversationViewControllerDelegate, BOTMessageInputToolbarDelegate, BOTMultiSelectionBarDelegate>

@property (nonatomic, strong) BOTMultipleActionInputView *multiInputView;
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
    self.shouldDisplayAvatarItemForAuthenticatedUser = NO;

    [self createNewConversation];
    [self configureCollectionViewCells];
    [self registerForNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.queryController.paginationWindow = -10;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.messageInputToolbar.textInputView becomeFirstResponder];
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
    [self.collectionView registerClass:[BOTMultipleCardBaseCollectionViewCell class] forCellWithReuseIdentifier:[BOTMultipleCardBaseCollectionViewCell reuseIdentifier]];
    
    // Receipt Cell
    UINib *receiptCell = [UINib nibWithNibName:@"BOTReceiptCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:receiptCell forCellWithReuseIdentifier:[BOTReceiptCollectionViewCell reuseIdentifier]];
    
    // Address Cell
    UINib *addressCell = [UINib nibWithNibName:@"BOTAddressCollectionViewCell" bundle:StaplesUIBundle()];
    [self.collectionView registerNib:addressCell forCellWithReuseIdentifier:[BOTAddressCollectionViewCell reuseIdentifier]];
    
    // Action Cell
    [self registerClass:[BOTActionCollectionViewCell class] forMessageCellWithReuseIdentifier:BOTActionCollectionViewCellReuseIdentifier];
    
    [self.collectionView registerClass:[BOTCollectionViewFooter class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:[BOTCollectionViewFooter reuseIdentifier]];
}

- (void)multipleActionInputView:(BOTMultipleActionInputView *)multipleActionInputView didSelectTitle:(NSString *)title actions:(NSString *)action
{
    BOTMessageInputToolbar *toolbar = (BOTMessageInputToolbar *)self.messageInputToolbar;
    [toolbar.textInputView resignFirstResponder];
    toolbar.textInputView.inputView = nil;
    [toolbar.textInputView reloadInputViews];
    
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

- (CGFloat)conversationViewController:(ATLConversationViewController *)viewController
                     heightForMessage:(LYRMessage *)message
                        withCellWidth:(CGFloat)cellWidth
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTAddressMIMEType]) {
        return [BOTAddressCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTReceiptMIMEType]) {
        return [BOTReceiptCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:BOTReturnMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTOrderMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTReorderMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:BOTActionMIMEType]) {
        return [BOTActionCollectionViewCell cellHeightForMessage:message inView:self.view];
    }
    return 0;
}

#pragma mark - ATLConversationViewControllerDataSource

- (nullable NSString *)conversationViewController:(ATLConversationViewController *)viewController reuseIdentifierForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:BOTProductListMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTAddressMIMEType]) {
        return [BOTAddressCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReceiptMIMEType]) {
        return [BOTReceiptCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTShipmentMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTRewardMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReturnMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTOrderMIMEType ]) {
        return [BOTMultipleCardBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTReorderMIMEType]) {
        return [BOTMultipleCardBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:BOTActionMIMEType]) {
        return [BOTActionCollectionViewCell reuseIdentifier];
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
    CGFloat screenWidth             = [[UIScreen mainScreen] bounds].size.width;
    
    // Create Custom Keyboard w/ Selection list.
    self.multiInputView = [[BOTMultipleActionInputView alloc] initWithSelectionTitles:[self selectionItems] actions:@[]];
    self.multiInputView.frame       = (CGRect){0.0, 0.0, screenWidth, 216.0f};
    self.multiInputView.delegate    = self;
    
    // Create Toolbar
    BOTMessageInputToolbar *toolbar = [[BOTMessageInputToolbar alloc] init];
    toolbar.customDelegate = self;
    toolbar.multiInputView = self.multiInputView;
    toolbar.textInputView.inputView = self.multiInputView;
    [toolbar displayMultiSelectionInputBar:YES];
    
    return toolbar;
}

#pragma mark - CollectionViewDelegate Overrides

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        NSString *reuseIdentifier = [BOTCollectionViewFooter reuseIdentifier];
        BOTCollectionViewFooter *footer = (BOTCollectionViewFooter *)[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [footer updateWithSelectionTitle:[self selectionItems]];
        [self.sectionFooters addObject:footer];
        return (UICollectionReusableView *)footer;
    }
    return [super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(320, 46);
}

#pragma mark - Message Input Toolbar Delegate

- (void)messageInputToolbar:(BOTMessageInputToolbar *)messageInputToolbar didTapListAccessoryButton:(UIButton *)listAccessoryButton
{
    //
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

- (BOOL)shouldDisplayAvatarItem
{
    return NO;
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