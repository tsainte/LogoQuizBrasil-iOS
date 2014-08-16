//
//  BLDatabaseManager.h
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BLLogoStatus.h"
#import "BLScore.h"
#import "BLUser.h"
#import "BLWallet.h"

#define kEntityLogoStatusID @"logostatus_%ld"
#define kEntityScore @"score"
#define kEntityWallet @"wallet"
#define kEntityUser @"user"

@interface BLDatabaseManager : NSObject

+ (void)saveData:(NSObject*)rootObject forEntity:(NSString*)entity;
+ (NSObject*)loadDataFromEntity:(NSString*)entity;

+ (void)startDatabase;
@end
