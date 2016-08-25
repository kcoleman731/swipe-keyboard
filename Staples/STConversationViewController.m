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
#import "STAddressCollectionViewCell.h"
#import "STShippingCollectionViewCell.h"
#import "STUtilities.h"
#import "STMultipleProductBaseCollectionViewCell.h"
#import "STReward.h"
#import "BOTRewardCollectionViewCell.h"
#import "STReorderCollectionViewCell.h"
#import "STMultiSelectionBar.h"
#import "BOTActionCollectionViewCell.h"

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
    // Product Call
    [self.collectionView registerClass:[STMultipleProductBaseCollectionViewCell class] forCellWithReuseIdentifier:[STMultipleProductBaseCollectionViewCell reuseIdentifier]];
    
    // Reorder Cell
    UINib *reorderCellNib = [UINib nibWithNibName:@"STReorderCollectionViewCell"  bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:reorderCellNib forCellWithReuseIdentifier:[STReorderCollectionViewCell reuseIdentifier]];
    
    // Reward Cell
    UINib *rewardCellNib = [UINib nibWithNibName:@"BOTRewardCollectionViewCell"  bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:rewardCellNib forCellWithReuseIdentifier:[BOTRewardCollectionViewCell reuseIdentifier]];
    
    // Address Cell
    UINib *addressCellNib = [UINib nibWithNibName:@"STAddressCollectionViewCell"  bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:addressCellNib forCellWithReuseIdentifier:[STAddressCollectionViewCell reuseIdentifier]];
    
    [self registerClass:[BOTActionCollectionViewCell class] forMessageCellWithReuseIdentifier:BOTActionCollectionViewCellReuseIdentifier];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[STAddressCollectionViewCell class]]] setTextColor:[UIColor darkGrayColor]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[STAddressCollectionViewCell class]]] setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular]];
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
    LYRMessagePart *messagePart;
    if ([title isEqualToString:STMultipleProductBaseCollectionViewCellTitle]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:[self fakeProductInfo] options:NSJSONWritingPrettyPrinted error:nil];
        messagePart = [LYRMessagePart messagePartWithMIMEType:STProductListMIMEType data:data];
    } else if ([title isEqualToString:STAddressCollectionViewCellTitle]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:[self fakeAddressInfo] options:NSJSONWritingPrettyPrinted error:nil];
        messagePart = [LYRMessagePart messagePartWithMIMEType:STAddressCollectionViewCellMimeType data:data];
    } else if ([title isEqualToString:STShippingCollectionViewCellTitle]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:[self fakeShipmentInfo] options:NSJSONWritingPrettyPrinted error:nil];
        messagePart = [LYRMessagePart messagePartWithMIMEType:STShipmentMIMEType data:data];
    } else if ([title isEqualToString:BOTRewardCollectionViewCellTitle]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:[self fakeRewardInfo] options:NSJSONWritingPrettyPrinted error:nil];
        messagePart = [LYRMessagePart messagePartWithMIMEType:STRewardMIMEType data:data];
    } else if ([title isEqualToString:STReorderCollectionViewCellTitle]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:[self fakeProductInfo] options:NSJSONWritingPrettyPrinted error:nil];
        messagePart = [LYRMessagePart messagePartWithMIMEType:STReorderCollectionViewCellMimeType data:data];
    }
    
    LYRMessage *message = [self.layerClient newMessageWithParts:@[messagePart] options:nil error:&error];
    if (!message) {
        NSLog(@"Failed to build message with error: %@", error);
        return;
    }
   [self sendMessage:message];
    NSLog(@"Message sent!");
}

#pragma mark - ATLConversationViewControllerDelegate

- (void)conversationViewController:(ATLConversationViewController *)viewController didSelectMessage:(LYRMessage *)message
{
    
}

- (CGFloat)conversationViewController:(ATLConversationViewController *)viewController heightForMessage:(LYRMessage *)message withCellWidth:(CGFloat)cellWidth
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:STAddressCollectionViewCellMimeType]) {
        return [STAddressCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell cellHeightForMessage:message];
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        return [BOTRewardCollectionViewCell cellHeight];
    } else if ([part.MIMEType isEqualToString:STReorderCollectionViewCellMimeType]) {
        return [STReorderCollectionViewCell cellHeight];
    }
    return 200;
}

#pragma mark - ATLConversationViewControllerDataSource

- (nullable NSString *)conversationViewController:(ATLConversationViewController *)viewController reuseIdentifierForMessage:(LYRMessage *)message
{
    return BOTActionCollectionViewCellReuseIdentifier;
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STProductListMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STAddressCollectionViewCellMimeType]) {
        return [STAddressCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STShipmentMIMEType]) {
        return [STMultipleProductBaseCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STRewardMIMEType]) {
        return [BOTRewardCollectionViewCell reuseIdentifier];
    } else if ([part.MIMEType isEqualToString:STReorderCollectionViewCellMimeType]) {
        return [STReorderCollectionViewCell reuseIdentifier];
    }
    return @"";
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

- (void)messageInputToolbar:(STMessageInputToolbar *)messageInputToolbar didTapListAccessoryButton:(UIButton *)listAccessoryButton
{
    STMultipleActionInputView *multiOptionSelectionView = [[STMultipleActionInputView alloc] initWithSelectionTitles:[self selectionItems]];
    multiOptionSelectionView.frame = CGRectMake(0, 0, 320, 240);
    multiOptionSelectionView.delegate = self;
    messageInputToolbar.textInputView.inputView = multiOptionSelectionView;
    [messageInputToolbar.textInputView becomeFirstResponder];
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
    return @[STMultipleProductBaseCollectionViewCellTitle, STAddressCollectionViewCellTitle, STShippingCollectionViewCellTitle , STReorderCollectionViewCellTitle, BOTRewardCollectionViewCellTitle];
}

- (NSDictionary *)fakeAddressInfo
{
    return @{STAddressName : @"Kevin Coleman",
             STAddressStreet : @"1776 Sacramento St, #704",
             STAddressCity: @"San Francisco, CA, 94109"};
}

- (NSDictionary *)fakeOrderInfo
{
    return @{STOrderNumberKey : @"Order Number: 123459853734",
             STOrderPriceKey : @"$20.99",
             STOrderItemKey: @"1 Item | ETA: 7/26/2016"};
}

- (NSDictionary *)fakeRewardInfo
{
    return @{STRewardTitleKey : @"Staples Rewards",
             STRewardNameKey : @"Kevin Coleman",
             STRewardMemberTypeKey: @"Plus Member",
             STRewardAmmountKey: @"$39.97",
             STRewardTypeKey: @"Redeemable",
             STRewardLinkKey: @"www.staples.com",
             STRewardBarcodeLinkKey: @"www.staples.com",
             STRewardBarcodeNumberKey: @"#1234567890"};
}

- (NSDictionary *)fakeProductInfo
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
    return @{@"data": @{ @"listItems" : [products copy]}};
}

- (NSDictionary *)fakeShipmentInfo
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
    return @{@"data": @{ @"shippmentTrackingList" : [products copy]}};
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