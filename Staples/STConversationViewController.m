//
//  STConversationViewController.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STConversationViewController.h"
#import "STActionInputView.h"

@implementation STConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *view = [[STActionInputView alloc] initWithButtonItems:@[@"Track My Shipment", @"Order New Supplies", @"Reorder Last Shipment", @"Scan School Supplies List"]];
    view.frame = CGRectMake(0, 0, 320, 280);
    view.backgroundColor = [UIColor redColor];
    self.messageInputToolbar.textInputView.inputView = view;
    
    // This could be in an init method.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil]; //this is it!
}

@end