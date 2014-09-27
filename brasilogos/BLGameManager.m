//
//  BLGameManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLGameManager.h"

@implementation BLGameManager

#define COINS_FOR_RIGHT_ANSWER 5
#define COINS_FOR_CLUE (-10)
#define COINS_FOR_SLOGAN (-20)
#define COINS_FOR_BOMB (-50)
#define COINS_FOR_MEDICINE (-200)

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
  
  //create transaction
  BLTransaction* transaction = [BLTransaction new];
  transaction.type = kTransacionGuessed;
  transaction.value = COINS_FOR_RIGHT_ANSWER;
  
  //update wallet
  BLWallet* wallet = [BLDatabaseManager wallet];
  [wallet addTransaction:transaction];
  [BLDatabaseManager saveData:wallet forEntity:kEntityWallet];
  
  //update score
  BLScore* score = [BLDatabaseManager score];
  score.correctLogos = score.correctLogos + 1;
  [BLDatabaseManager saveData:score forEntity:kEntityScore];
  
  //update logostatus
  BLLogoStatus* status = [BLDatabaseManager logoStatus:[self.logo[@"id"] longValue]];
  status.hasHitTheAnswer = YES;
  [self saveStatus:status];
}

- (void)isWrongAnswer {
  
  [self.delegate isWrongAnswer];
}

- (void)saveStatus:(BLLogoStatus*)status {
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,[self.logo[@"id"] longValue]];
  [BLDatabaseManager saveData:status forEntity:entity];
}

- (BOOL)authorizeHelp:(BLGameHelp)help {

  BOOL alreadyPurchased = [self alreadyPurchased:help];
  if (alreadyPurchased) return YES;
  
  NSInteger cost = [self costHelp:help];
  NSInteger myMoney = [[BLDatabaseManager wallet] coins];
  BOOL hasMoney = cost + myMoney >= 0;
  if (hasMoney) {
    [self buyHelp:help];
  }
  
  return hasMoney;
}

- (BOOL)alreadyPurchased:(BLGameHelp)help {
  
  BLLogoStatus* status = [BLDatabaseManager logoStatus:[self.logo[@"id"] longValue]];
  BOOL alreadyPurchased;
  switch (help) {
    case BLGameHelpClueOne:
      alreadyPurchased = status.hasUsedFirstClue;
      break;
    case BLGameHelpClueTwo:
      alreadyPurchased = status.hasUsedSecondClue;
      break;
    case BLGameHelpSlogan:
      alreadyPurchased = status.hasUsedSlogan;
      break;
    case BLGameHelpBomb:
      alreadyPurchased = status.hasUsedBomb;
      break;
    case BLGameHelpMedicine:
      alreadyPurchased = status.hasUsedMedicine;
      break;
    default:
      break;
  }
  return alreadyPurchased;
}

- (NSInteger)costHelp:(BLGameHelp)help {
  
  NSInteger cost;
  switch (help) {
    case BLGameHelpClueOne:
      cost = COINS_FOR_CLUE;
      break;
    case BLGameHelpClueTwo:
      cost = COINS_FOR_CLUE;
      break;
    case BLGameHelpSlogan:
      cost = COINS_FOR_SLOGAN;
      break;
    case BLGameHelpBomb:
      cost = COINS_FOR_BOMB;
      break;
    case BLGameHelpMedicine:
      cost = COINS_FOR_MEDICINE;
      break;
    default:
      break;
  }
  return cost;
}

- (void)buyHelp:(BLGameHelp)help {
  
  BLLogoStatus* status = [BLDatabaseManager logoStatus:[self.logo[@"id"] longValue]];
  switch (help) {
    case BLGameHelpClueOne:
      status.hasUsedFirstClue = YES;
      break;
    case BLGameHelpClueTwo:
      status.hasUsedSecondClue = YES;
      break;
    case BLGameHelpSlogan:
      status.hasUsedSlogan = YES;
      break;
    case BLGameHelpBomb:
      status.hasUsedBomb = YES;
      break;
    case BLGameHelpMedicine:
      status.hasUsedMedicine = YES;
      status.hasHitTheAnswer = YES;
      break;
    default:
      break;
  }
  [BLDatabaseManager saveLogoStatus:status];
  
  BLTransaction* transaction = [self makeTransactionHelp:help];
  BLWallet* wallet = [BLDatabaseManager wallet];
  [wallet addTransaction:transaction];
  [BLDatabaseManager saveData:wallet forEntity:kEntityWallet];
}

- (BLTransaction*)makeTransactionHelp:(BLGameHelp)help {
  
  BLTransaction* transaction = [BLTransaction new];

  switch (help) {
      
    case BLGameHelpClueOne:
      transaction.type = kTransactionBuyClue;
      transaction.value = COINS_FOR_CLUE;
      break;
      
    case BLGameHelpClueTwo:
      transaction.type = kTransactionBuyClue;
      transaction.value = COINS_FOR_CLUE;
      break;
    
    case BLGameHelpSlogan:
      transaction.type = kTransactionBuySlogan;
      transaction.value = COINS_FOR_SLOGAN;
      break;
    
    case BLGameHelpBomb:
      transaction.type = kTransactionBuyBomb;
      transaction.value = COINS_FOR_BOMB;
      break;
    
    case BLGameHelpMedicine:
      transaction.type = kTransactionBuyMedicine;
      transaction.value = COINS_FOR_MEDICINE;
      break;
    
    default:
      break;
  }
  return transaction;
}

#pragma mark - static methods for IndexLevel

+ (BOOL)canPlayLevel:(NSInteger)levelIndex {
  
  NSInteger correctLogos = [[BLDatabaseManager score] correctLogos];
  NSInteger minimumLogosRequired = kMaximumLogoPerLevel*(levelIndex -1)*0.667;
  return correctLogos >= minimumLogosRequired;
}

+ (NSInteger)logosToNextLevel:(NSInteger)levelIndex {
  
  NSInteger correctLogos = [[BLDatabaseManager score] correctLogos];
  NSInteger minimumLogosRequired = kMaximumLogoPerLevel*(levelIndex -1)*0.667;
  return minimumLogosRequired - correctLogos;
}
@end
