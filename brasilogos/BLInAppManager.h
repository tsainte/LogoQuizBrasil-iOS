//
//  BLInAppManager.h
//  brasilogos
//
//  Created by Tiago Bencardino on 23/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface BLInAppManager : NSObject

@property NSArray* productIdentifiers;
+ (BLInAppManager*)shared;
- (id)initWithProductIdentifiers:(NSArray *)productIdentifiers;

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end
