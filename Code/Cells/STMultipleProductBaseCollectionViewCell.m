//
//  STMultipleProductsBaseCollectionViewCell.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleProductBaseCollectionViewCell.h"
#import "STMultipleProductsCollectionViewLayout.h"
#import "STUtilities.h"

NSString *const STMultipleProductBaseCollectionViewCellTitle = @"Product Cell";
NSString *const STMultipleProductBaseCollectionViewCellId = @"STMultipleProductBaseCollectionViewCellId";

typedef NS_ENUM(NSInteger, STCellType) {
    STCellTypeProduct = 0,
    STCellTypeItem = 1,
};

@interface STMultipleProductBaseCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, STSuggestedProductCollectionViewCellDelegate, STItemCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) STMultipleProductsCollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic) STCellType cellType;

@end

@implementation STMultipleProductBaseCollectionViewCell

#pragma mark - Initializers / Common Init

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
    self.contentView.backgroundColor = [UIColor clearColor];
    [self layoutCollectionView];
    
    UINib *productNib = [UINib nibWithNibName:@"STProductCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:productNib forCellWithReuseIdentifier:[STSuggestedProductCollectionViewCell reuseIdentifier]];
    
    UINib *itemNib = [UINib nibWithNibName:@"STItemCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:itemNib forCellWithReuseIdentifier:[STItemCollectionViewCell reuseIdentifier]];
}

- (void)layoutCollectionView
{
    self.collectionViewLayout = [[STMultipleProductsCollectionViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 16.0, 0.0, 0.0);
    self.collectionView.contentOffset = CGPointMake(16.0, 0.0);
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self.collectionViewLayout;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = self.collectionViewLayout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    [self addCollecitonViewConstraints];
}

+ (NSString *)reuseIdentifier
{
    return STMultipleProductBaseCollectionViewCellId;
}

+ (CGFloat)cellHeight
{
    return 260;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [STItemCollectionViewCell reuseIdentifier];
    STItemCollectionViewCell *cell = (STItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    STProductItem *item = self.products[indexPath.row];
    [cell setProductItem:item];
    cell.delegate = self;
    return cell;
}

#pragma mark - ATLMessagePresenting

NSString *const STMessagePartBTSItemsKey = @"btsItems";
NSString *const STMessagePartListItemsKey = @"listItems";

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        // Handle the error;
    }
    
    NSArray *productJSON;
    NSDictionary *data = json[STMessagePartDataKey];
    if (data[STMessagePartBTSItemsKey]) {
        productJSON = data[STMessagePartBTSItemsKey];
    } else if (data[STMessagePartListItemsKey]) {
        productJSON = data[STMessagePartListItemsKey];
    }
    
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (NSDictionary *productData in productJSON) {
        STProductItem *product = [STProductItem productWithData:productData];
        [products addObject:product];
    }
    self.products = products;
    [self.collectionView reloadData];
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // ???
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // ??
}

#pragma mark - STMultipleProductsCollectionViewCellDelegate Calls

- (void)productCell:(STSuggestedProductCollectionViewCell *)cell addButtonWasPressedWithProduct:(STProductItem *)item
{
    [self.productDelegate productCell:cell addButtonWasPressedWithProduct:item];
}

- (void)productCell:(STSuggestedProductCollectionViewCell *)cell infoButtonWasPressedWithProduct:(STProductItem *)item
{
    [self.productDelegate productCell:cell infoButtonWasPressedWithProduct:item];
}

- (void)ItemCell:(STItemCollectionViewCell *)cell addButtonWasPressedWithItem:(STProductItem *)item
{
    //
}

- (void)ItemCell:(STItemCollectionViewCell *)cell infoButtonWasPressedWithItem:(STProductItem *)item
{
    //
}

#pragma mark - NSLayoutConstraints For UI

- (void)addCollecitonViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
}

@end
