//
//  BLFirebaseAnalytics.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/07/2016.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import "BLFirebaseAnalytics.h"

@implementation BLFirebaseAnalytics

+ (void)logWrongAnswer:(NSString*)wrongAnswer forLogo:(NSDictionary*)logo {
    
    [self logEventWithName:@"user_tried_wrong_answer" parameters:@{@"logo_id" : logo[@"id"], @"logo_name" : logo[@"nome"], @"user_answer" : wrongAnswer}];
}

+ (void)logItemConsumed:(NSString*)item forLogo:(NSDictionary*)logo {
    
    [self logEventWithName:@"user_consumed_item" parameters:@{@"logo_id" : logo[@"id"], @"logo_name" : logo[@"nome"], @"item" : item}];
}

+ (void)logEventWithName:(NSString*)name parameters:(nullable NSDictionary<NSString *,NSObject *> *)parameters {
    
#ifndef DEBUG
    NSLog(@"asdf");
    [FIRAnalytics logEventWithName:name parameters:parameters];
#endif
}

@end
