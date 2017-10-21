//
//  BLBaseViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 13/10/2017.
//  Copyright © 2017 MobWiz. All rights reserved.
//

#import "BLBaseViewController.h"

@interface BLBaseViewController ()

@property (nonatomic, strong) UIButton *coinButton;

@end

@implementation BLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButtonBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateCoins];
}

- (void)createButtonBar {
    
    self.coinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.coinButton setBackgroundImage:[UIImage imageNamed:@"coin_nonumber_small"] forState:UIControlStateNormal];
    
    NSString *coins = [@([[BLDatabaseManager wallet] coins]) description];
    [self.coinButton setTitle:coins forState:UIControlStateNormal];
    
    self.coinButton.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:10];
    [self.coinButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.coinButton.titleLabel.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.coinButton.titleLabel.layer.shadowOffset = CGSizeMake(1, 1);
    
    [[self.coinButton.widthAnchor constraintEqualToConstant:40] setActive:YES];
    [[self.coinButton.heightAnchor constraintEqualToConstant:40] setActive:YES];
    
    [self.coinButton addTarget:self action:@selector(shopTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.coinButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)updateCoins {
    
    NSString *coins = [@([[BLDatabaseManager wallet] coins]) description];
    [self.coinButton setTitle:coins forState:UIControlStateNormal];
}

- (void)shopTapped {
    
    [BLController showShoppingOnViewController:self];
}


@end
