//
//  BLMainViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLMainViewController.h"
#import "GameCenterManager.h"

@interface BLMainViewController ()

@property NSString *leaderboardIdentifier;

@end

@implementation BLMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self roundButtons];
}

- (void)authenticateGameCenter {
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];   //it hides
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];    // it shows
}

- (void)roundButtons {
    
    [BLStyling roundView:self.playButton];
    [BLStyling roundView:self.boardButton];
    [BLStyling roundView:self.aboutButton];
}

- (IBAction)showGameCenter:(id)sender {
    
    GameCenterManager *gcm = [[GameCenterManager alloc] init];
    gcm.parent = self;
    [gcm authenticateLocalUserWithCompletionHandler:^(bool success) {
        if (success) {
            [self showLeaderboardAndAchievements:YES];
        } else {
            //alert
            NSLog(@"oops");
        }
    }];
}

- (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard {
    
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    } else {
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
