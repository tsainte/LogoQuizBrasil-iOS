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

@property NSDictionary *products;
@property NSArray *productKeys;
@property NSArray *fiveProductButtons;

@end

@implementation BLShoppingOverlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [BLInAppManager shared].delegate = self.delegate;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.alpha = 0.0f;
    self.fiveProductButtons = @[self.coins100, self.coins250, self.coins750, self.coins2000, self.removeAds];
    self.productKeys = @[kInApp100Coins, kInApp250Coins, kInApp750Coins, kInApp2000Coins, kInAppNoAds];
    [self roundViews];
    
    [self loadProductsFromAppStore];
}

- (void)roundViews {
    
    [BLStyling roundView:self.content corner:15];
    
    for (UIView *productView in self.fiveProductButtons) {
        [BLStyling roundView:productView];
    }
    [BLStyling roundView:self.restore];
}

- (void)loadProductsFromAppStore {
    
    self.products = nil;
    //start refreshing
    [[BLInAppManager shared] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            [self mountProductDictionary:products];
            [self reloadButtons];
        }
        //    [self.refreshControl endRefreshing];
    }];
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
    
    NSMutableDictionary *productsDict = [NSMutableDictionary new];
    
    for (SKProduct *product in products) {
        [productsDict setObject:product forKey:product.productIdentifier];
    }
    self.products = productsDict;
}

- (void)reloadButtons {
    
    NSString *format1 = @"%@";
    NSString *format2 = [BLController isIpad] ? @"%@ (%.0f%% de desconto)" : @"%@ (%.0f%% dsc)";
    
    for (int i = 0; i < self.productKeys.count; i++) {
        NSString *productKey = self.productKeys[i];
        UIButton *buyButton = self.fiveProductButtons[i];
        SKProduct *product;
        @try {
            product = self.products[productKey];
        }
        @catch (NSException *exception) {
            continue;
        }
        
        NSString *text1 = [NSString stringWithFormat:format1, product.localizedTitle];
        
        double discount = [self calcDiscount:product];
        NSString *text2 = discount ? [NSString stringWithFormat:format2, [self getCurrency:product], discount] : [self getCurrency:product];
        
        [((UILabel*)[buyButton viewWithTag:1]) setText:text1];
        [((UILabel*)[buyButton viewWithTag:2]) setText:text2];
    }
    NSLog(@"products: %@", self.products);
}

- (NSString*)getCurrency:(SKProduct*)product {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:product.priceLocale];
    NSString *localizedMoneyString = [formatter stringFromNumber:product.price];
    
    return localizedMoneyString;
}

- (NSInteger)calcDiscount:(SKProduct*)product {
    
    double oringinalPricePerCoin = 0.99 / 100;
    double numberOfCoins = 0;
    
    if ([product.productIdentifier isEqualToString:self.productKeys[1]]) {
        numberOfCoins = 250;
    } else if ([product.productIdentifier isEqualToString:self.productKeys[2]]) {
        numberOfCoins = 750;
    } else if ([product.productIdentifier isEqualToString:self.productKeys[3]]) {
        numberOfCoins = 2000;
    }
    
    if (numberOfCoins) {
        double price = [product.price doubleValue];
        double pricePerCoin = price / numberOfCoins;
        double percentage = 100 - ((pricePerCoin / oringinalPricePerCoin) * 100);
        NSInteger discount = round(percentage);
        
        return discount;
    } else {
        return 0;
    }
}

- (IBAction)overlayTapped:(id)sender {
    
    [self close];
}

- (IBAction)buy100coins:(id)sender {
    
    if (self.products) {
        [[BLInAppManager shared] buyProduct:self.products[kInApp100Coins]];
    }
}

- (IBAction)buy250coins:(id)sender {
    
    if (self.products) {
        [[BLInAppManager shared] buyProduct:self.products[kInApp250Coins]];
    }
}

- (IBAction)buy750coins:(id)sender {
    
    if (self.products) {
        [[BLInAppManager shared] buyProduct:self.products[kInApp750Coins]];
    }
}

- (IBAction)buy2000coins:(id)sender {
    
    if (self.products) {
        [[BLInAppManager shared] buyProduct:self.products[kInApp2000Coins]];
    }
}

- (IBAction)buyRemoveAds:(id)sender {
    
    if (self.products) {
        [[BLInAppManager shared] buyProduct:self.products[kInAppNoAds]];
    }
}

- (IBAction)restoreBuys:(id)sender {
    
    [[BLInAppManager shared] restoreCompletedTransactions];
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
