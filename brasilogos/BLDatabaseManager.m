//
//  BLDatabaseManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLDatabaseManager.h"
#import "BLJSONDatabase.h"
#import "BLGameManager.h"

@implementation BLDatabaseManager

+ (void)saveData:(NSObject*)rootObject forEntity:(NSString*)entity {
  
  NSString* filePath = [BLDatabaseManager libraryFilePathToFolder:entity];
  [NSKeyedArchiver archiveRootObject:rootObject toFile:filePath];
}

+ (NSObject*)loadDataFromEntity:(NSString*)entity {
  
  NSObject* objectData;
  NSString* filePath = [BLDatabaseManager libraryFilePathToFolder:entity];
  
  if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    objectData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  }
  return objectData;
}

// We are using /Library because we want to maintain on a private directory. To public directory, use /Document
+ (NSString*)libraryFilePathToFolder:(NSString*)folder {
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
  NSString *directoryPath = [paths objectAtIndex:0];
  NSString *filePath = [directoryPath stringByAppendingPathComponent:folder];
  return filePath;
}

+ (BLWallet*)wallet {
  
  BLWallet* wallet = (BLWallet*)[BLDatabaseManager loadDataFromEntity:kEntityWallet];
  if (!wallet) {
    wallet = [BLWallet new];
//    wallet.coins = [BLDatabaseManager migrateCoinsFromDefaults];
    [BLDatabaseManager saveData:wallet forEntity:kEntityWallet];
  }
  return wallet;
}

+ (BLScore*)score {
  
  BLScore* score = (BLScore*)[BLDatabaseManager loadDataFromEntity:kEntityScore];
  if (!score) {
    score = [BLScore new];
//    score.correctLogos = [BLDatabaseManager migrateCorrectLogosFromDefaults];
    [BLDatabaseManager saveData:score forEntity:kEntityScore];
  }
  return score;
}

+ (BLUser*)user {
  
  id user = [BLDatabaseManager loadDataFromEntity:kEntityUser];
  if (!user) {
    user = [BLUser new];
    [BLDatabaseManager saveData:user forEntity:kEntityUser];
  }
  return user;
}

+ (BLLogoStatus*)logoStatus:(long)logoId {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,logoId];
  BLLogoStatus* status = (BLLogoStatus*)[BLDatabaseManager loadDataFromEntity:entity];
  return status;
}

+ (void)saveLogoStatus:(BLLogoStatus*)logoStatus {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,(long)logoStatus.identifier];
  [BLDatabaseManager saveData:logoStatus forEntity:entity];
}

+ (NSInteger)migrateCorrectLogosFromDefaults {
  
  return 0;
}

+ (NSInteger)migrateCoinsFromDefaults {
  
  return 0;
}

+ (NSInteger)correctLogosForLevel:(NSInteger)level {
  
  NSInteger countCorrectLogos = 0;
  NSMutableArray* logos = [BLJSONDatabase shared].levels[level-1];
  for (NSDictionary* logo in logos) {
    NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,[logo[@"id"] longValue]];
    BLLogoStatus* status = (BLLogoStatus*)[BLDatabaseManager loadDataFromEntity:entity];
    if (status.hasHitTheAnswer) countCorrectLogos++;
  }
  return countCorrectLogos;
}

+ (NSInteger)completedLevel {
  
  NSInteger countCompletedLevel = 0;
  for (int i = 0; i < [BLJSONDatabase shared].levels.count; i++) {
    NSInteger correctsPerLevel = [BLDatabaseManager correctLogosForLevel:i+1];
    if (correctsPerLevel == 16) countCompletedLevel++;
  }
  return countCompletedLevel;
}

#pragma mark - migrate

+ (NSArray*)getLogosStatus:(int)level {
  
  NSString* levelKey = [NSString stringWithFormat:@"level%d_logoStatus",level];
  NSArray* logosStatus = [[NSUserDefaults standardUserDefaults] arrayForKey:levelKey];
//  NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
  return logosStatus;
}


#define kLogoStatusCorrect @"correct"
#define kLogoStatusYES @"YES"

+ (BOOL)isCorrectLogo:(NSDictionary*)logo {
  
  NSString* correct = logo[kLogoStatusCorrect];
  return [correct isEqualToString:kLogoStatusYES];
}


+ (void)migrate {
  
  for (int i = 0; i < [BLJSONDatabase shared].levels.count; i++) {
    NSArray* logosStatus = [BLDatabaseManager getLogosStatus:(i+1)];
    for (NSDictionary* logo in logosStatus) {
      if ([BLDatabaseManager isCorrectLogo:logo]) {
        BLGameManager* gameManager = [[BLGameManager alloc] initWithLogo:logo delegate:nil];
        [gameManager saveCorrectOnDatabase];
      }
    }
  }
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"migrated"];
}

+ (void)migrateIfNeeded {
  
  BOOL isMigrated = [[NSUserDefaults standardUserDefaults] boolForKey:@"migrated"];
  BOOL hasSomethingToMigrate = [BLDatabaseManager getLogosStatus:1] != nil;
  if (!isMigrated && hasSomethingToMigrate) {
    [BLDatabaseManager migrate];
  }
}


@end
