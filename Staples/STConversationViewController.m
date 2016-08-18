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

@interface STConversationViewController ()<STActionInputViewDelegate, ATLConversationViewControllerDataSource>

@end

@implementation STConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STMultipleActionInputView *multiOptionSelectionView = [[STMultipleActionInputView alloc] initWithButtonTitles:@[@"Track My Shipment", @"Order New Supplies", @"Reorder Last Shipment", @"Scan School Supplies List", @"Track My Shipment", @"Order New Supplies", @"Reorder Last Shipment", @"Scan School Supplies List"]];
    
    multiOptionSelectionView.frame = CGRectMake(0, 0, 320, 280);
    self.messageInputToolbar.textInputView.inputView = multiOptionSelectionView;
}

- (void)actionInputView:(STActionInputView *)actionInputView didSelectItem:(NSString *)item
{
    NSError *error;
    if (!self.conversation) {
        LYRConversationOptions *options = [LYRConversationOptions new];
        options.distinctByParticipants = NO;
        LYRConversation *conversation = [self.layerClient newConversationWithParticipants:[NSSet setWithObject:@"2"] options:options error:&error];
        if (!conversation) {
            NSLog(@"Failed to build conversatio with error: %@", error);
            return;
        }
        [self setConversation:conversation];
    }
    LYRMessagePart *messagePart = [LYRMessagePart messagePartWithText:item];
    LYRMessage *message = [self.layerClient newMessageWithParts:@[messagePart] options:nil error:&error];
    if (!message) {
        NSLog(@"Failed to build message with error: %@", error);
        return;
    }
   [self sendMessage:message];
    NSLog(@"Message sent!");
}

- (id<ATLParticipant>)conversationViewController:(ATLConversationViewController *)conversationViewController participantForIdentity:(LYRIdentity *)identity
{
    return nil;
}

- (NSAttributedString *)conversationViewController:(ATLConversationViewController *)conversationViewController attributedStringForDisplayOfDate:(NSDate *)date
{
    return [[NSAttributedString alloc] initWithString:@"test"];
}

- (NSAttributedString *)conversationViewController:(ATLConversationViewController *)conversationViewController attributedStringForDisplayOfRecipientStatus:(NSDictionary *)recipientStatus
{
    return [[NSAttributedString alloc] initWithString:@"read"];
}

@end