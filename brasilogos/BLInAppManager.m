//
//  BLInAppManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 23/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLInAppManager.h"
#import <StoreKit/StoreKit.h>

@interface BLInAppManager()  <SKProductsRequestDelegate>


@end
@implementation BLInAppManager

SKProductsRequest * _productsRequest;

RequestProductsCompletionHandler _completionHandler;

NSMutableSet * _purchasedProductIdentifiers;

+ (BLInAppManager *)shared {
  
  static dispatch_once_t once;
  static BLInAppManager * sharedInstance;
  dispatch_once(&once, ^{
    NSArray * productIdentifiers = @[ kInApp100Coins, kInApp250Coins, kInApp750Coins, kInApp2000Coins, kInAppNoAds];
    sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
  });
  return sharedInstance;
  
}
- (id)initWithProductIdentifiers:(NSArray *)productIdentifiers {
  
  if ((self = [super init])) {
    
    // Store product identifiers
    self.productIdentifiers = productIdentifiers;
    
    // Check for previously purchased products
    _purchasedProductIdentifiers = [NSMutableSet set];
    for (NSString * productIdentifier in _productIdentifiers) {
      BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
      if (productPurchased) {
        [_purchasedProductIdentifiers addObject:productIdentifier];
        NSLog(@"Previously purchased: %@", productIdentifier);
      } else {
        NSLog(@"Not purchased: %@", productIdentifier);
      }
    }
    
  }
  [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
  return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
  
  _completionHandler = [completionHandler copy];
  
  _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
  _productsRequest.delegate = self;
  [_productsRequest start];
  
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
  
  NSLog(@"Loaded list of products...");
  _productsRequest = nil;
  
  NSArray * skProducts = response.products;
  for (SKProduct * skProduct in skProducts) {
    NSLog(@"Found product: %@ %@ %0.2f",
          skProduct.productIdentifier,
          skProduct.localizedTitle,
          skProduct.price.floatValue);
  }
  
  _completionHandler(YES, skProducts);
  _completionHandler = nil;
  
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
  
  NSLog(@"Failed to load list of products.");
  _productsRequest = nil;
  
  _completionHandler(NO, nil);
  _completionHandler = nil;
  
}

- (NSString *) priceAsString:(SKProduct*)product {
  
  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
  [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [formatter setLocale:[product priceLocale]];
  
  NSString *str = [formatter stringFromNumber:[product price]];
  return str;
}

#pragma mark - show me the money
- (void)buyProduct:(SKProduct *)product {
  
  NSLog(@"Buying %@...", product.productIdentifier);
  
  SKPayment * payment = [SKPayment paymentWithProduct:product];
  [[SKPaymentQueue defaultQueue] addPayment:payment];
  
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
  for (SKPaymentTransaction * transaction in transactions) {
    switch (transaction.transactionState)
    {
      case SKPaymentTransactionStatePurchased:
        [self completeTransaction:transaction];
        break;
      case SKPaymentTransactionStateFailed:
        [self failedTransaction:transaction];
        break;
      case SKPaymentTransactionStateRestored:
        [self restoreTransaction:transaction];
      default:
        break;
    }
  };
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
  NSLog(@"completeTransaction...");
  
  [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
  [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
  NSLog(@"restoreTransaction...");
  
  [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
  [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
  [self.delegate refreshUI];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
  
  NSLog(@"failedTransaction...");
  if (transaction.error.code != SKErrorPaymentCancelled)
  {
    NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
  }
  
  [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)provideContentForProductIdentifier:(NSString*)productIdentifier {
  
  if ([productIdentifier isEqualToString:kInAppNoAds]) {
    BLUser* user = [BLDatabaseManager user];
    user.boughtRemoveAds = YES;
    [BLDatabaseManager saveData:user forEntity:kEntityUser];
    
  } else {
    BLTransaction* transaction = [BLTransaction new];
    transaction.type = kTransactionInApp;
    
    if ([productIdentifier isEqualToString:kInApp100Coins]) {
      transaction.value = 100;
    } else if ([productIdentifier isEqualToString:kInApp250Coins]) {
      transaction.value = 250;
    } else if ([productIdentifier isEqualToString:kInApp750Coins]) {
      transaction.value = 750;
    } else if ([productIdentifier isEqualToString:kInApp2000Coins]) {
      transaction.value = 2000;
    } else {
      return;
    }
    
    BLWallet* wallet = [BLDatabaseManager wallet];
    [wallet addTransaction:transaction];
    [BLDatabaseManager saveData:wallet forEntity:kEntityWallet];
    [self.delegate refreshUI];
  }
}

- (void)restoreCompletedTransactions {
  
  [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
@end
