//
//  BLJSONParser.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLDatabase : NSObject

@property NSArray* levels;
+ (BLDatabase*)shared;

@end
