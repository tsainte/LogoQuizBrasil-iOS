//
//  BLLevelViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLLevelViewController.h"
#import "BLLogosListViewController.h"
#import "BLShoppingOverlayViewController.h"

@interface BLLevelViewController ()

@end

@implementation BLLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Nível %ld", self.levelID];
    self.adBanner.hidden = [[BLDatabaseManager user] boughtRemoveAds];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    [self loadBanner];
    
    self.adBanner.hidden = [[BLDatabaseManager user] boughtRemoveAds];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.logos.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"cell"
                                  forIndexPath:indexPath];
    
    NSDictionary *logo = self.logos[indexPath.row];
    [BLStyling roundView:[cell viewWithTag:2] corner:[BLController isIpad] ? 12 : 6];
    [BLStyling roundView:[cell viewWithTag:3] corner:[BLController isIpad] ? 6 : 3];
    
    UIImageView *imageView = (UIImageView* )[cell viewWithTag:1];
    [self configureImage:imageView logo:logo];
    
    return cell;
}

- (void)configureImage:(UIImageView*)imageView logo:(NSDictionary*)logo {
    
    NSString *entity = [NSString stringWithFormat:kEntityLogoStatusID, [logo[@"id"] longValue]];
    BLLogoStatus *status = (BLLogoStatus* )[BLDatabaseManager loadDataFromEntity:entity];
    
    if (status.hasHitTheAnswer) {
        imageView.image = [UIImage imageNamed:logo[@"imagem"]];
        [[imageView superview] setAlpha:0.5];
    } else {
        imageView.image = [UIImage imageNamed:logo[@"imagemModificada"]];
        [[imageView superview] setAlpha:1.0];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
    BLLogosListViewController *logosVC = segue.destinationViewController;
    logosVC.logos = self.logos;
    logosVC.current = indexPath.row;
}

#pragma mark - BLBannerManagerDelegate

- (void)loadBanner {
    
    [[BLBannerManager shared] resetAdView:self];
}

- (void)bannerWillAppear:(UIView *)banner {
    
    if (![self.adBanner.subviews containsObject:banner]) {
        [self.adBanner addSubview:banner];
    }
}

- (void)bannerWillDisappear:(UIView *)banner {
    
    [banner removeFromSuperview];
}

#pragma mark - InAppDelegate

- (void)refreshUI {
    
    [self updateCoins];
    self.adBanner.hidden = [[BLDatabaseManager user] boughtRemoveAds];
}

@end
