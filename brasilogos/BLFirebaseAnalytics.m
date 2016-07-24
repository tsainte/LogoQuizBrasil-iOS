//
//  BLFirebaseAnalytics.m
//  brasilogos
//
//  Created by Tiago Bencardino on 16/07/2016.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import "BLFirebaseAnalytics.h"

@implementation BLFirebaseAnalytics

- (void)logEventWithName:(NSString*)name parameters:(nullable NSDictionary<NSString *, NSObject *> *)parameters {
    
    [FIRAnalytics logEventWithName:name parameters:parameters];
}

@end
