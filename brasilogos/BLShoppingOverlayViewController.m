//
//  BLShoppingOverlayViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 17/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLShoppingOverlayViewController.h"
#import "BLInAppManager.h"

@interface BLShoppingOverlayViewController ()

@property NSDictionary* products;
@property NSArray* fiveProductButtons;

@end

@implementation BLShoppingOverlayViewController

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
  self.view.backgroundColor = [UIColor clearColor];
  self.view.alpha = 0.0f;
  self.fiveProductButtons = @[self.coins100, self.coins250, self.coins750, self.coins2000, self.removeAds];
  [self roundViews];
  
  [self loadProductsFromAppStore];
}

- (void)roundViews {

  [BLStyling roundView:self.content corner:15];
  for (UIView* productView in self.fiveProductButtons) {
    [BLStyling roundView:productView];
  }
  [BLStyling roundView:self.restore];
}

- (void)loadProductsFromAppStore {
  
  self.products = nil;
//start refreshing
  [[BLInAppManager shared] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
    if (success) {
      [self mountProductDictionary:self.products];
      [self reloadButtons];
    }
//    [self.refreshControl endRefreshing];
  }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  
  [self fadeIn];
}

- (void)fadeIn {
  
  [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    self.view.alpha = 1.0;
  } completion:^(BOOL completed) {
  }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)mountProductDictionary:(NSArray*)products {
  
  NSMutableDictionary* productsDict = [NSMutableDictionary new];
  for (SKProduct* product in products){
    [productsDict setObject:product forKey:product.productIdentifier];
  }
  self.products = productsDict;
}

- (void)reloadButtons {
  
  
  NSLog(@"products: %@",self.products);
}

- (IBAction)overlayTapped:(id)sender {
  
  [self close];
}

- (void)close {
  
  self.view.alpha = 1.0;
  [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    self.view.alpha = 0.0;
  } completion:^(BOOL completed) {
    
    [self dismissViewControllerAnimated:NO completion:nil];
  }];
}
@end
