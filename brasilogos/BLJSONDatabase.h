//
//  BLJSONParser.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLJSONDatabase : NSObject

@property NSArray *levels;
+ (BLJSONDatabase*)shared;

@end
