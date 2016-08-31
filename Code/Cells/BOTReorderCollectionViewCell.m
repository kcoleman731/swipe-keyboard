//
//  STReorderCollectionViewCell.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTReorderCollectionViewCell.h"
#import "BOTMultipleProductsCollectionViewLayout.h"
#import "BOTReorderItemCollectionViewCell.h"
#import "BOTUtilities.h"

NSString *const BOTReorderCollectionViewCellTitle= @"Reorder Cell";
NSString *const BOTReorderCollectionViewCellMimeType = @"json/reorder";
NSString *const BOTReorderCollectionViewCellReuseIdentifier = @"BOReorderCollectionViewCellReuseIdentifier";

@interface BOTReorderCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *seeAllOrdersLabel;
@property (strong, nonatomic) IBOutlet UIButton *orderButton;
@property (strong, nonatomic) IBOutlet UIButton *pastOrdersButton;
@property (strong, nonatomic) BOTMultipleProductsCollectionViewLayout *collectionViewLayout;

@end

@implementation BOTReorderCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

+ (NSString *)reuseIdentifier
{
    return BOTReorderCollectionViewCellReuseIdentifier;
}

+ (CGFloat)cellHeight
{
    return 260;
}

- (void)commonInit
{
    self.view.layer.borderColor = BOTLightGrayColor().CGColor;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderWidth = 2;
    self.view.clipsToBounds = YES;

    [self layoutCollectionView];
    
    UINib *itemNib = [UINib nibWithNibName:@"BOTReorderItemCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.itemCollectionView registerNib:itemNib forCellWithReuseIdentifier:[BOTReorderItemCollectionViewCell reuseIdentifier]];
    [self.orderButton setTitle:@"Add entire order to cart" forState:UIControlStateNormal];
    [self.pastOrdersButton setTitle:@"See past orders" forState:UIControlStateNormal];
}

- (void)layoutCollectionView
{
    self.collectionViewLayout = [[BOTMultipleProductsCollectionViewLayout alloc] init];
    self.itemCollectionView.collectionViewLayout = self.collectionViewLayout;
    self.itemCollectionView.contentInset = UIEdgeInsetsMake(0.0, 16.0, 0.0, 0.0);
    self.itemCollectionView.contentOffset = CGPointMake(16.0, 0.0);
    self.itemCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.itemCollectionView.delegate = self.collectionViewLayout;
    self.itemCollectionView.dataSource = self;
    self.itemCollectionView.backgroundColor = [UIColor clearColor];
    self.itemCollectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [BOTReorderItemCollectionViewCell reuseIdentifier];
    BOTReorderItemCollectionViewCell *cell = (BOTReorderItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    BOTProduct *item = self.products[indexPath.row];
    [cell setProductItem:item];
    return cell;
}

#pragma mark - ATLMessagePresenting

- (void)presentMessage:(LYRMessage *)message
{
    LYRMessagePart *part = message.parts[0];
    NSArray *data = [NSJSONSerialization JSONObjectWithData:part.data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (NSDictionary *dataDict in data) {
        BOTProduct *item = [BOTProduct productWithData:dataDict];
        [products addObject:item];
    }
    self.products = products;
    [self.itemCollectionView reloadData];
    self.orderNumberLabel.text = @"Order #1289349874353";
}

- (void)updateWithSender:(nullable id<ATLParticipant>)sender
{
    // ???
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    // ??
}

@end
