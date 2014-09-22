//
//  BLAlertOverlayViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 20/09/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLAlertOverlayViewController.h"

@interface BLAlertOverlayViewController ()

@end

@implementation BLAlertOverlayViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  [self roundViews];
  self.view.backgroundColor = [UIColor clearColor];
  self.view.alpha = 0.0f;
  self.titleLabel.text = self.titleText;
  self.textLabel.text = self.text;
}

- (void)roundViews {
  
  [BLStyling roundView:self.noButton];
  [BLStyling roundView:self.yesButton];
  [BLStyling roundView:self.contentView corner:15.0f];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)noTapped:(id)sender {
  
  [self closeWithAction:NO];
}

- (IBAction)yesTapped:(id)sender {
  
  [self closeWithAction:YES];
}

- (void)closeWithAction:(BOOL)action {
  
  self.view.alpha = 1.0;
  [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    self.view.alpha = 0.0;
  } completion:^(BOOL completed) {
    if (action)
      [self dismissViewControllerAnimated:NO completion:self.executeAction];
    else
      [self dismissViewControllerAnimated:NO completion:nil];
  }];
}
@end
