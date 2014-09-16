//
//  BLTransaction.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/09/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLTransaction.h"

@implementation BLTransaction

#define kCodeKeyType @"type"
#define kCodeKeyValue @"value"

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [self init];
  
  self.type = [aDecoder decodeObjectForKey:kCodeKeyType];
  self.value = [aDecoder decodeIntegerForKey:kCodeKeyValue];
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  
  [aCoder encodeInteger:self.value forKey:kCodeKeyValue];
  [aCoder encodeObject:self.type forKey:kCodeKeyType];
}
@end
