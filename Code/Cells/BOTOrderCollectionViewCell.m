
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
    // Nada for now
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupCollectionView];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.bgView.layer.cornerRadius = 4.0f;
    self.bgView.layer.masksToBounds = NO;
    self.bgView.layer.borderWidth = 1.0f;
    self.bgView.layer.borderColor = BOTLightGrayColor().CGColor;
    
    self.bgView.layer.shadowColor = BOTLightGrayColor().CGColor;
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 3;
    self.bgView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.bgView.userInteractionEnabled = NO;
}

- (void)setupCollectionView
{
    self.datasource = [[BOTOrderCollectionViewCellDataSource alloc] initWithCollectionView:self.collectionView];
    self.layout     = [[BOTOrderCollectionViewCellLayout alloc] init];
    self.collectionView.delegate = self.layout;
    self.collectionView.dataSource = self.datasource;
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.backgroundColor = BOTLightGrayColor();
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - Setter

- (void)setOrder:(BOTOrder *)order
{
    if (_order != order) {
        _order = order;
        [self.datasource setOrder:order];
        [self.orderNumberButton setTitle:order.orderNumber forState:UIControlStateNormal];
        self.priceLabel.text        = @"$254.65"; //order.totalPrice;
        NSString *formattedDate     = [[[self class] transactionDateFormatter] stringFromDate:order.orderDate];
//        NSString *itemsLabelContent = [NSString stringWithFormat:@"%ld items | %@", (unsigned long)order.items.count, formattedDate];
        
        NSString *itemsLabelContent = [NSString stringWithFormat:@"%ld items | %@", (unsigned long)order.items.count, @"11/02/2016"];
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
