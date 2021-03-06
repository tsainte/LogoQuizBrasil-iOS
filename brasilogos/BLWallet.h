//
//  BLWallet.h
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLTransaction.h"

@interface BLWallet : NSObject

@property NSInteger coins;
@property NSMutableArray *transactions;

- (void)addTransaction:(BLTransaction*)transaction;

@end
