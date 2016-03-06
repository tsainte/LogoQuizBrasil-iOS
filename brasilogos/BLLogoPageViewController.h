//
//  BLLogoPageViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 07/02/16.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLLogoPageViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property NSArray *logoViewControllers;

- (void)selectPageAtIndex:(NSInteger)index;

@end
