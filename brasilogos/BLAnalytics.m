//
//  BLAnalytics.m
//  brasilogos
//
//  Created by Tiago Bencardino on 24/07/2016.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import "BLAnalytics.h"
#import "BLFlurryAnalytics.h"
#import "BLFirebaseAnalytics.h"

@interface BLAnalytics()

@property NSArray *services;

@end

@implementation BLAnalytics

+ (id)sharedInstance {
    
    static BLAnalytics * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BLAnalytics alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    
    if (self = [super init]) {
        self.services = @[[BLFlurryAnalytics new]];
    }
    
    return self;
}

- (void)logWrongAnswer:(NSString*)wrongAnswer forLogo:(NSDictionary*)logo {
    
    for (id<BLAnalyticsProtocol> service in self.services) {
         [service logEventWithName:@"user_tried_wrong_answer" parameters:@{@"logo_id" : logo[@"id"], @"logo_name" : logo[@"nome"], @"user_answer" : wrongAnswer}];
    }
   
}

- (void)logItemConsumed:(NSString*)item forLogo:(NSDictionary*)logo {
    
    for (id<BLAnalyticsProtocol> service in self.services) {
        [service logEventWithName:@"user_consumed_item" parameters:@{@"logo_id" : logo[@"id"], @"logo_name" : logo[@"nome"], @"item" : item}];
    }
}

@end
