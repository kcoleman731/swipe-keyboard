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

@interface STConversationViewController () <STMultipleActionInputViewDelegate, ATLConversationViewControllerDataSource, ATLConversationViewControllerDelegate, STMessageInputToolbarDelegate>

@end

@implementation STConversationViewController

NSString *const STAddressCell = @"Address Cell";
NSString *const STAddressCellMimeType = @"json/address";

NSString *const STShippingCell = @"Shipping Cell";
NSString *const STShippingCellMimeType = @"json/shipping";

NSString *const STItemCell = @"Item Cell";
NSString *const STItemCellMimeType = @"json/item";

NSString *const STOptionCell = @"Option Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    [self createNewConversation];
    [self configureCollectionViewCells];
}

- (void)configureCollectionViewCells
{
    UINib *nib = [UINib nibWithNibName:@"STAddressCollectionViewCell"  bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[STAddressCollectionViewCell reuseIdentifier]];
    
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[STAddressCollectionViewCell class]]] setTextColor:[UIColor grayColor]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[STAddressCollectionViewCell class]]] setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular]];
}

- (void)multipleActionInputView:(STMultipleActionInputView *)multipleActionInputView didSelectTitle:(NSString *)title
{
    NSError *error;
    LYRMessagePart *messagePart;
    if ([title isEqualToString:STItemCell]) {
    
    }else if ([title isEqualToString:STAddressCell]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:[self fakeAddressInfo] options:NSJSONWritingPrettyPrinted error:nil];
        messagePart = [LYRMessagePart messagePartWithMIMEType:STAddressCellMimeType data:data];
    }else if ([title isEqualToString:STShippingCell]) {
        
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

- (CGFloat)conversationViewController:(ATLConversationViewController *)viewController heightForMessage:(LYRMessage *)message withCellWidth:(CGFloat)cellWidth
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STItemCellMimeType]) {
        return 260;
    }else if ([part.MIMEType isEqualToString:STAddressCellMimeType]) {
        return 260;
    }else if ([part.MIMEType isEqualToString:STShippingCellMimeType]) {
        return 260;
    }
    return 200;
}

#pragma mark - ATLConversationViewControllerDataSource

- (nullable NSString *)conversationViewController:(ATLConversationViewController *)viewController reuseIdentifierForMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    if ([part.MIMEType isEqualToString:STItemCellMimeType]) {
        return @"";
    }else if ([part.MIMEType isEqualToString:STAddressCellMimeType]) {
        return [STAddressCollectionViewCell reuseIdentifier];
    }else if ([part.MIMEType isEqualToString:STShippingCellMimeType]) {
        return @"";
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
    multiOptionSelectionView.frame = CGRectMake(0, 0, 320, 280);
    multiOptionSelectionView.delegate = self;
    messageInputToolbar.textInputView.inputView = multiOptionSelectionView;
    [messageInputToolbar.textInputView becomeFirstResponder];
}

#pragma mark - FAKE DATA SHIIIT

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
    return @[STAddressCell, STItemCell, STShippingCell, STOptionCell];
}

- (NSDictionary *)fakeAddressInfo
{
    return @{STAddressName : @"Kevin Coleman",
             STAddressStreet : @"1776 Sacramento St, #704",
             STAddressCity: @"San Francisco, CA, 94109"};
}

@end