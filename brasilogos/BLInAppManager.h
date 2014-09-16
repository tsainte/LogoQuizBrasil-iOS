//
//  BLInAppManager.h
//  brasilogos
//
//  Created by Tiago Bencardino on 23/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kInApp100Coins @"br.com.mobwiz.brasilogos.100coins"
#define kInApp250Coins @"br.com.mobwiz.brasilogos.250coins"
#define kInApp750Coins @"br.com.mobwiz.brasilogos.750coins"
#define kInApp2000Coins @"br.com.mobwiz.brasilogos.2000coins"
#define kInAppNoAds @"br.com.mobwiz.brasilogos.noads"

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface BLInAppManager : NSObject <SKPaymentTransactionObserver>

@property NSArray* productIdentifiers;
+ (BLInAppManager*)shared;
- (id)initWithProductIdentifiers:(NSArray *)productIdentifiers;

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end
