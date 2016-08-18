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

@interface STConversationViewController () <STMultipleActionInputViewDelegate, ATLConversationViewControllerDataSource>

@end

@implementation STConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    
    STMultipleActionInputView *multiOptionSelectionView = [[STMultipleActionInputView alloc] initWithSelectionItems:[self selectionItems]];
    multiOptionSelectionView.frame = CGRectMake(0, 0, 320, 280);
    multiOptionSelectionView.delegate = self;
    self.messageInputToolbar.textInputView.inputView = multiOptionSelectionView;
}

- (void)multipleActionInputView:(STMultipleActionInputView *)multipleActionInputView didSelectItem:(NSString *)item
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
    return [[NSAttributedString alloc] initWithString:@"Today 2:30PM"];
}

- (NSAttributedString *)conversationViewController:(ATLConversationViewController *)conversationViewController attributedStringForDisplayOfRecipientStatus:(NSDictionary *)recipientStatus
{
    return [[NSAttributedString alloc] initWithString:@"Sent"];
}

- (NSArray *)selectionItems
{
    return @[@"Track My Shipment", @"Order New Supplies", @"Reorder Last Shipment",
             @"Scan School Supplies List", @"Option 1", @"Option 2",
             @"Option 3", @"Option 4"];
}

@end