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
    NSArray * productIdentifiers = @[
                                  @"br.com.mobwiz.brasilogos.100coins",
                                  @"br.com.mobwiz.brasilogos.250coins",
                                  @"br.com.mobwiz.brasilogos.750coins",
                                  @"br.com.mobwiz.brasilogos.2000coins",
                                  @"br.com.mobwiz.brasilogos.noads",
                                  ];
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
@end
