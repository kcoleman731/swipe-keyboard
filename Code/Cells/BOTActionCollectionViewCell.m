//
//  BOTActionCollectionViewCell.m
//  
//
//  Created by Kevin Coleman on 8/25/16.
//
//

#import "BOTActionCollectionViewCell.h"
#import "BOTUtilities.h"

NSString *const BOTActionMIMEType = @"application/json+actionobject";
NSString *const BOTActionCollectionViewCellButtonTapped = @"BOTActionCollectionViewCellButtonTapped";
NSString *const BOTActionCollectionViewCellReuseIdentifier = @"BOTActionCollectionViewCellReuseIdentifier";

@interface ATLBaseCollectionViewCell ()

@property (nonatomic) NSLayoutConstraint *bubbleWithAvatarLeadConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutAvatarLeadConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleViewWidthConstraint;

- (void)lyr_baseInit;

@end

@interface ATLIncomingMessageCollectionViewCell ();

- (void)configureLayoutConstraints;

- (NSAttributedString *)attributedStringForText:(NSString *)text;

+ (ATLMessageCollectionViewCell *)sharedCell;

@end

@interface LYRMessage ()

@property (nonatomic, readwrite) NSArray *parts;

@end

@interface BOTActionCollectionViewCell ()

@property (nonatomic) UIButton *actionButton;

@end

@implementation BOTActionCollectionViewCell


- (void)lyr_baseInit
{
    self.actionButton = [UIButton new];
    [self.actionButton setTitle:@"View My Cart" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:BOTBlueColor() forState:UIControlStateNormal];
    [self.actionButton addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionButton.layer.cornerRadius = 4;
    self.actionButton.backgroundColor = [UIColor whiteColor];
    self.actionButton.layer.borderColor = BOTBlueColor().CGColor;
    self.actionButton.layer.borderWidth = 1;
    [self.contentView addSubview:self.actionButton];
    [super lyr_baseInit];
    
    [self configureActionButtonConstraints];
}

+ (NSString *)reuseIdentifier
{
    return BOTActionCollectionViewCellReuseIdentifier;
}

NSString *const BOTHeaderTitleKey = @"headerTitle";
NSString *const BOTBackToSchoolActionKey = @"btsAction";

- (void)presentMessage:(LYRMessage *)message
{
    NSString *header = [self parseTextForMessage:message];
    [self.bubbleView updateWithAttributedText:[super attributedStringForText:header]];
    [self.bubbleView updateProgressIndicatorWithProgress:0.0 visible:NO animated:NO];
    self.accessibilityLabel = [NSString stringWithFormat:@"Message: %@", header];
    
    [self updateBubbleWidth:300];
}

- (NSString *)parseTextForMessage:(LYRMessage *)message
{
    NSDictionary *json = [self parseDataForMessagePart:message.parts[0]];
    NSDictionary *data = json[BOTMessagePartDataKey];
    NSDictionary *action = data[BOTBackToSchoolActionKey];
    return action[BOTHeaderTitleKey];
}

- (NSDictionary *)parseDataForMessagePart:(LYRMessagePart *)part
{
    NSString *dataString = [[NSString alloc] initWithData:part.data encoding:NSUTF8StringEncoding];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return json;
}

//----------------------------
// Warning Atlas Hacking Below
//----------------------------

+ (CGFloat)cellHeightForMessage:(LYRMessage *)message inView:(UIView *)view
{
    NSString *text = [[[self alloc] init] parseTextForMessage:message];
    UIFont *font = [[[self class] appearance] messageTextFont];
    if (!font) {
        font = [super sharedCell].messageTextFont;
    }
    CGSize size = ATLTextPlainSize(text, font);
    size.height += ATLMessageBubbleLabelVerticalPadding * 2;
    return size.height + 52;
}

- (void)configureLayoutConstraints
{
    self.bubbleWithAvatarLeadConstraint = [NSLayoutConstraint new];
    self.bubbleWithoutAvatarLeadConstraint = [NSLayoutConstraint new];
    
    CGFloat maxBubbleWidth = ATLMaxCellWidth() + ATLMessageBubbleLabelHorizontalPadding * 2;
    self.bubbleViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:maxBubbleWidth];
    [self.contentView addConstraint:self.bubbleViewWidthConstraint];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-52]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

- (void)configureActionButtonConstraints
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
}

- (void)actionButtonTapped:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTActionCollectionViewCellButtonTapped object:self];
}

@end
