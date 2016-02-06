//
//  BLWallet.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLWallet.h"

@implementation BLWallet

#define kCodeKeyCoins @"coins"
#define kCodeKeyTransactions @"transactions"

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [self init];
    
    self.coins = [aDecoder decodeIntegerForKey:kCodeKeyCoins];
    self.transactions = [aDecoder decodeObjectForKey:kCodeKeyTransactions];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInteger:self.coins forKey:kCodeKeyCoins];
    [aCoder encodeObject:self.transactions forKey:kCodeKeyTransactions];
}

- (void)addTransaction:(BLTransaction*)transaction {
    
    if (!self.transactions) {
        self.transactions = [NSMutableArray new];
    }
    self.coins = self.coins + transaction.value;
    [self.transactions addObject:transaction];
}

@end
