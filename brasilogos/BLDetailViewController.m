//
//  BLDetailViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 03/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLDetailViewController.h"

@interface BLDetailViewController ()

@end

@implementation BLDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)soma:(id)sender {
    
    self.bigTrailingConstraint.constant = self.smallHorizontalConstraint.constant;
    self.bigVerticalConstraint.constant = self.smallHorizontalConstraint.constant;
    self.bigWidthConstraint.constant = 55;
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.coinBig.hidden = YES;
    }];
}

- (IBAction)subtrai:(id)sender {
    self.coinBig.hidden = NO;
    self.bigTrailingConstraint.constant = 101;
    self.bigVerticalConstraint.constant = 130;
    self.bigWidthConstraint.constant = 110;
    [self.view layoutIfNeeded];
}

@end
