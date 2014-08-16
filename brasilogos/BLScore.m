//
//  BLScore.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLScore.h"

@implementation BLScore

#define kCodeKeyCorrectLogos @"correctLogos"

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [self init];
  
  self.correctLogos = [aDecoder decodeIntegerForKey:kCodeKeyCorrectLogos];
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  
  [aCoder encodeInteger:self.correctLogos forKey:kCodeKeyCorrectLogos];
}
@end
