//
//  BLLogoStatus.h
//  brasilogos
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLLogoStatus : NSObject

@property NSInteger identifier;

@property BOOL hasUsedFirstClue;
@property BOOL hasUsedSecondClue;
@property BOOL hasUsedSlogan;

@property BOOL hasUsedBomb;
@property BOOL hasUsedMedicine;

@property BOOL hasHitTheAnswer;

@end
