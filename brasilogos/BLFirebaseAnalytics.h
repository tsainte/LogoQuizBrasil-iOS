//
//  BLFirebaseAnalytics.h
//  brasilogos
//
//  Created by Tiago Bencardino on 16/07/2016.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface BLFirebaseAnalytics : NSObject

+ (void)logWrongAnswer:(NSString*)wrongAnswer forLogo:(NSDictionary*)logo;

+ (void)logItemConsumed:(NSString*)item forLogo:(NSDictionary*)logo;

@end
