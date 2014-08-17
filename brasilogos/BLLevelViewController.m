//
//  BLLevelViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLLevelViewController.h"
#import "BLLogoViewController.h"
#import "BLShoppingOverlayViewController.h"

@interface BLLevelViewController ()

@end

@implementation BLLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  
  [super viewDidLoad];
  self.title = [NSString stringWithFormat:@"Nível %d",self.levelID];
//  self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
  
  [self.collectionView reloadData];
  [self updateCoins];
}

- (void)updateCoins {
  
  self.coinsLabel.text = [@([[BLDatabaseManager wallet] coins]) description];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
  return self.logos.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"cell"
                                  forIndexPath:indexPath];
  
  NSDictionary* logo = self.logos[indexPath.row];
  [BLStyling roundView:[cell viewWithTag:2] corner:6];
  [BLStyling roundView:[cell viewWithTag:3] corner:6];
  UIImageView *imageView = (UIImageView*)[cell viewWithTag:1];
  [self configureImage:imageView logo:logo];
  
  return cell;
}

- (void)configureImage:(UIImageView*)imageView logo:(NSDictionary*)logo {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,[logo[@"id"] longValue]];
  BLLogoStatus* status = (BLLogoStatus*)[BLDatabaseManager loadDataFromEntity:entity];
  
  if (status.hasHitTheAnswer) {
    imageView.image = [UIImage imageNamed:logo[@"imagem"]];
    [[imageView superview] setAlpha:0.5];
  } else {
    imageView.image = [UIImage imageNamed:logo[@"imagemModificada"]];
    [[imageView superview] setAlpha:1.0];
  }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath* indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
  BLLogoViewController *logoVC = segue.destinationViewController;
  logoVC.logo = self.logos[indexPath.row];
}

- (IBAction)shopTapped:(id)sender {
  
  BLShoppingOverlayViewController* shopVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BLShoppingOverlayViewController"];
  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
  [self presentViewController:shopVC animated:NO completion:nil];
}
@end
