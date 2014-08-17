//
//  BLShoppingOverlayViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 17/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLShoppingOverlayViewController.h"

@interface BLShoppingOverlayViewController ()

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
  self.view.alpha = 0.0f;
  [self roundViews];
}

- (void)roundViews {

  [BLStyling roundView:self.content corner:15];
  [BLStyling roundView:self.coins100];
  [BLStyling roundView:self.coins250];
  [BLStyling roundView:self.coins750];
  [BLStyling roundView:self.coins2000];
  [BLStyling roundView:self.removeAds];
  [BLStyling roundView:self.restore];
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
