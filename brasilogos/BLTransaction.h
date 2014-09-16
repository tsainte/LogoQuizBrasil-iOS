//
//  BLTransaction.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/09/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTransactionBuyClue @"Usou dica"
#define kTransactionBuySlogan @"Usou slogan"
#define kTransactionBuyBomb @"Usou bomba"
#define kTransactionBuyMedicine @"Revelou logo"
#define kTransacionGuessed @"Acertou logo"
#define kTransactionInApp @"Comprou moedas"
#define kTransactionMigrate @"Saldo anterior"

@interface BLTransaction : NSObject

@property NSString* type;
@property NSInteger value;

@end
