//
//  BLGameManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLGameManager.h"

@implementation BLGameManager

- (id)initWithLogo:(NSDictionary*)logo delegate:(id<BLGameManagerDelegate>)delegate {
  
  if (self = [super init]) {
    self.logo = logo;
    self.delegate = delegate;
  }
  return self;
}

- (void)tryAnswer:(NSString*)playerAnswer {
  
  NSArray* answers = [self getDiacriticAnswers];
  playerAnswer = [self getDiacriticString:playerAnswer];
  
  if([answers containsObject:playerAnswer]) {
    [self isCorrectAnswer];
  } else {
    [self isWrongAnswer];
  }
}

- (NSArray*)getDiacriticAnswers {
  
  NSMutableArray* answers = [NSMutableArray new];
  NSString* correctAnswer = [self getDiacriticString:self.logo[@"nome"]];
  [answers addObject:correctAnswer];
  
  NSArray* alternatives = [self getAlternativesAsArray];
  for (NSString* answer in alternatives) {
    NSString* diacriticAnswer = [answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    diacriticAnswer = [self getDiacriticString:diacriticAnswer];
    [answers addObject:diacriticAnswer];
  }
  return answers;
}

- (NSArray*)getAlternativesAsArray {
  
  NSString* alternativeString = self.logo[@"alternativo"];
  NSArray* alternatives = [alternativeString componentsSeparatedByString:@","];
  return alternatives;
}
- (NSString*)getDiacriticString:(NSString*)string {
  
  return [[string lowercaseString] stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
}

- (void)isCorrectAnswer {
  
  [self saveCorrectOnDatabase];
  [self.delegate isCorrectAnswer];
}

- (void)saveCorrectOnDatabase {
  
  //update wallet
  //update score
  //update logostatus
  BLLogoStatus* status = [self getLogoStatus];
  status.hasHitTheAnswer = YES;
  [self saveStatus:status];
}

- (void)isWrongAnswer {
  
  [self.delegate isWrongAnswer];
}

- (BLLogoStatus*)getLogoStatus {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,[self.logo[@"id"] longValue]];
  return (BLLogoStatus*)[BLDatabaseManager loadDataFromEntity:entity];
}

- (void)saveStatus:(BLLogoStatus*)status {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,[self.logo[@"id"] longValue]];
  [BLDatabaseManager saveData:status forEntity:entity];
}
@end
