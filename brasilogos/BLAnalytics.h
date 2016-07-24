//
//  BLAnalytics.h
//  brasilogos
//
//  Created by Tiago Bencardino on 24/07/2016.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BLAnalyticsProtocol

- (void)logEventWithName:(nonnull NSString*)name parameters:(nullable NSDictionary<NSString *, NSObject *> *)parameters;

@end

@interface BLAnalytics : NSObject

+ (nonnull id)sharedInstance;

- (void)logCorrectAnswer:(nonnull NSString*)correctAnswer forLogo:(nonnull NSDictionary*)logo;
- (void)logWrongAnswer:(nonnull NSString*)wrongAnswer forLogo:(nonnull NSDictionary*)logo;
- (void)logItemConsumed:(nonnull NSString*)item forLogo:(nonnull NSDictionary*)logo;

@end
