
//
//  BOTOrderCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 9/1/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderCollectionViewCell.h"
#import "BOTOrderCollectionViewCellDataSource.h"
#import "BOTOrderCollectionViewCellLayout.h"
#import "BOTUtilities.h"
#import "BOTOrder.h"

NSString *const BOTOrderCollectionViewCellCellReuseIdentifier = @"BOTOrderCollectionViewCellCellReuseIdentifier";
NSString *const BOTOrderCollectionViewCellTitle               = @"Reorder Cell";
NSString *const BOTOrderCollectionViewCellMimeType            = @"application/json+listreorder";

@interface BOTOrderCollectionViewCell ()

// UI
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemsLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderNumberButton;

// Model
@property (nonatomic, strong) BOTOrderCollectionViewCellDataSource *datasource;
@property (nonatomic, strong) BOTOrderCollectionViewCellLayout *layout;

@end

@implementation BOTOrderCollectionViewCell

#pragma mark - Reuse ID / Cell Height

+ (NSString *)reuseIdentifier
{
    return BOTOrderCollectionViewCellCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 200;
}

#pragma mark - Init / Layout

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.bubbleView.hidden = YES;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupCollectionView];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor      = [UIColor whiteColor];
    self.bgView.layer.borderColor    = BOTLightGrayColor().CGColor;
    self.bgView.layer.cornerRadius   = 4;
    self.bgView.layer.borderWidth    = 2;
}

- (void)setupCollectionView
{
    self.datasource = [[BOTOrderCollectionViewCellDataSource alloc] initWithCollectionView:self.collectionView];
    self.layout     = [[BOTOrderCollectionViewCellLayout alloc] init];
    self.collectionView.delegate = self.layout;
    self.collectionView.dataSource = self.datasource;
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - ATL Parsing

- (void)presentMessage:(LYRMessage *)message
{
    NSDictionary *payload   = [self parseDataForMessagePart:message.parts[0]];
    NSDictionary *orderDict = payload[@"data"][@"reorderItem"][0][@"order"];
    BOTOrder *order         = [BOTOrder orderWithData:orderDict];
    [self setOrder:order];
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

#pragma mark - Setter

- (void)setOrder:(BOTOrder *)order
{
    if (_order != order) {
        _order = order;
        [self.datasource setOrder:order];
        [self.orderNumberButton setTitle:order.orderNumber forState:UIControlStateNormal];
        self.priceLabel.text        = order.totalPrice;
        NSString *formattedDate     = [[[self class] transactionDateFormatter] stringFromDate:order.orderDate];
        NSString *itemsLabelContent = [NSString stringWithFormat:@"%ld items | %@", (unsigned long)order.items.count, formattedDate];
        self.itemsLabel.text        = itemsLabelContent;
    }
}

#pragma mark - Date Formatter

+ (NSDateFormatter *)transactionDateFormatter
{
    static NSDateFormatter *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle        = NSDateFormatterLongStyle;
        formatter.timeStyle        = NSDateFormatterNoStyle;
        [formatter setLocale:[NSLocale currentLocale]];
        __instance = formatter;
    });
    return __instance;
}

@end
