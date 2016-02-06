//
//  BLMainViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface BLMainViewController : UIViewController <GKGameCenterControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *boardButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

- (IBAction)showGameCenter:(id)sender;

@end
