//
//  BLFlurryAnalytics.m
//  brasilogos
//
//  Created by Tiago Bencardino on 24/07/2016.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import "BLFlurryAnalytics.h"
#import "Flurry.h"

@implementation BLFlurryAnalytics

- (void)logEventWithName:(NSString*)name parameters:(nullable NSDictionary<NSString *, NSObject *> *)parameters {
    
    [Flurry logEvent:name withParameters:parameters];
}

@end
