//
//  BLLogoStatus.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLLogoStatus.h"

#define kCodeKeyIdentifier @"identifier"
#define kCodeKeyHasUsedFirstClue @"hasUsedFirstClue"
#define kCodeKeyHasUsedSecondClue @"hasUsedSecondClue"
#define kCodeKeyHasUsedSlogan @"hasUsedSlogan"
#define kCodeKeyHasUsedBomb @"hasUsedBomb"
#define kCodeKeyHasUsedMedicine @"hasUsedMedicine"
#define kCodeKeyHasHitTheAnswer @"hasHitTheAnswer"

@implementation BLLogoStatus

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [self init];
    
    self.identifier = [aDecoder decodeIntegerForKey:kCodeKeyIdentifier];
    self.hasUsedFirstClue = [aDecoder decodeBoolForKey:kCodeKeyHasUsedFirstClue];
    self.hasUsedSecondClue = [aDecoder decodeBoolForKey:kCodeKeyHasUsedSecondClue];
    self.hasUsedSlogan = [aDecoder decodeBoolForKey:kCodeKeyHasUsedSlogan];
    self.hasUsedBomb = [aDecoder decodeBoolForKey:kCodeKeyHasUsedBomb];
    self.hasUsedMedicine = [aDecoder decodeBoolForKey:kCodeKeyHasUsedMedicine];
    self.hasHitTheAnswer = [aDecoder decodeBoolForKey:kCodeKeyHasHitTheAnswer];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInteger:self.identifier forKey:kCodeKeyIdentifier];
    [aCoder encodeBool:self.hasUsedFirstClue forKey:kCodeKeyHasUsedFirstClue];
    [aCoder encodeBool:self.hasUsedSecondClue forKey:kCodeKeyHasUsedSecondClue];
    [aCoder encodeBool:self.hasUsedSlogan forKey:kCodeKeyHasUsedSlogan];
    [aCoder encodeBool:self.hasUsedBomb forKey:kCodeKeyHasUsedBomb];
    [aCoder encodeBool:self.hasUsedMedicine forKey:kCodeKeyHasUsedMedicine];
    [aCoder encodeBool:self.hasHitTheAnswer forKey:kCodeKeyHasHitTheAnswer];
}

@end
