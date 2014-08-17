//
//  BLDatabaseManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLDatabaseManager.h"

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
    wallet.coins = [BLDatabaseManager migrateCoinsFromDefaults];
    [BLDatabaseManager saveData:wallet forEntity:kEntityWallet];
  }
  return wallet;
}

+ (BLScore*)score {
  
  BLScore* score = (BLScore*)[BLDatabaseManager loadDataFromEntity:kEntityScore];
  if (!score) {
    score = [BLScore new];
    score.correctLogos = [BLDatabaseManager migrateCorrectLogosFromDefaults];
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
@end