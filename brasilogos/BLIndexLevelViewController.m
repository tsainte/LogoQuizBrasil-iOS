//
//  BLIndexLevelViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLIndexLevelViewController.h"
#import "BLJSONDatabase.h"
#import "BLLevelViewController.h"
#import "BLShoppingOverlayViewController.h"

@interface BLIndexLevelViewController ()

@property NSArray* levels;

@end

@implementation BLIndexLevelViewController

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
  self.levels = [BLJSONDatabase shared].levels;
}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:YES];
  [self loadBanner];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
  return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.levels.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString* cellIdentifier = @"cell";
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  UILabel* level = (UILabel*)[cell viewWithTag:1];
  level.text = [NSString stringWithFormat:@"Nível %ld", indexPath.row+1];
  
  return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

  NSInteger index = [[self.tableView indexPathForSelectedRow] row];
  BLLevelViewController* levelVC = [segue destinationViewController];
  levelVC.levelID = index+1;
  levelVC.logos = self.levels[index];
}

- (IBAction)shopTapped:(id)sender {
  
  BLShoppingOverlayViewController* shopVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BLShoppingOverlayViewController"];
  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
  [self presentViewController:shopVC animated:NO completion:nil];
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
@end
