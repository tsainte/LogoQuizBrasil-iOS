//
//  BLUser.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLUser.h"

@implementation BLUser

#define kCodeKeyBoughtRemoveAds @"boughtRemoveAds"
#define kCodeKeyFbId @"fbId"

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [self init];
    
    self.boughtRemoveAds = [aDecoder decodeBoolForKey:kCodeKeyBoughtRemoveAds];
    self.fbId = [aDecoder decodeObjectForKey:kCodeKeyFbId];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeBool:self.boughtRemoveAds forKey:kCodeKeyBoughtRemoveAds];
    [aCoder encodeObject:self.fbId forKey:kCodeKeyFbId];
}

@end
