//
//  BLJSONParser.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLJSONDatabase.h"
#import "BLDatabaseManager.h"

@implementation BLJSONDatabase

static BLJSONDatabase* singleton;

+ (BLJSONDatabase*)shared {
  @synchronized(self) {
    if (!singleton) {
      singleton = [[BLJSONDatabase alloc] init];
      [singleton parse];
    }
  }
  return singleton;
}

- (NSData*)dataFromFile {
  
  NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"db.json"];
  NSData* data = [NSData dataWithContentsOfFile:filePath];
  return data;
}

- (void)parse {
  
  NSError* error;
  NSArray* json =  [NSJSONSerialization JSONObjectWithData:[self dataFromFile] options: NSJSONReadingMutableContainers error: &error];
  if (!error) {
    [self putLogosIntoLevels:json];
  }
}

- (void)putLogosIntoLevels:(NSArray*)json {
 
  NSMutableArray* levels = [NSMutableArray new];
  NSMutableArray* logos = [NSMutableArray new];
  [levels addObject:logos];
  int anchor = 0;
  int maximum = 16;
  for (NSDictionary* logo in json) {
    
    if (anchor == maximum){
      anchor = 1;
      logos = [NSMutableArray new];
      [levels addObject:logos];
    } else {
      anchor++;
    }
    [logos addObject:logo];
    [self createLogoStatusIfNeeded:logo[@"id"]];
  }
  self.levels = levels;
}

- (void)createLogoStatusIfNeeded:(NSNumber*)identifier {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID, [identifier longValue]];
  BLLogoStatus* status = (BLLogoStatus*)[BLDatabaseManager loadDataFromEntity:entity];
  if (!status) {
    status = [[BLLogoStatus alloc] init];
    status.identifier = [identifier integerValue];
    [BLDatabaseManager saveData:status forEntity:entity];
  }
  
}
@end
