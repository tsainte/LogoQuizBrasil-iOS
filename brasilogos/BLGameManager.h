//
//  BLGameManager.h
//
//
//  Created by Tiago Bencardino on 16/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BLGameManagerDelegate <NSObject>

@required
- (void)isCorrectAnswer;

@required
- (void)isWrongAnswer;

@end

@interface BLGameManager : NSObject

@property NSDictionary* logo;
@property id<BLGameManagerDelegate> delegate;


- (id)initWithLogo:(NSDictionary*)logo delegate:(id<BLGameManagerDelegate>)delegate;
- (void)tryAnswer:(NSString*)playerAnswer;

@end
