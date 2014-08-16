//
//  BLJSONParser.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLDatabase.h"

@implementation BLDatabase

static BLDatabase* singleton;

+ (BLDatabase*)shared {
  
  if (!singleton) {
    singleton = [[BLDatabase alloc] init];
    [singleton parse];
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
  }
  self.levels = levels;
}
@end
