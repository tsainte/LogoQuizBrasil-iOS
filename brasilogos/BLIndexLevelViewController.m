//
//  BLIndexLevelViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLIndexLevelViewController.h"
#import "BLJSONDatabase.h"
#import "BLLevelViewController.h"
#import "BLShoppingOverlayViewController.h"
#import "BLGameManager.h"

@interface BLIndexLevelViewController ()

@property NSArray *levels;

@end

@implementation BLIndexLevelViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.levels = [BLJSONDatabase shared].levels;
    self.heigthAdBannerConstraint.constant = [[BLDatabaseManager user] boughtRemoveAds] ? 0 : [BLController isIpad] ? 90 : 50;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self loadBanner];
    [self updateCoins];
    [self.tableView reloadData];
    
    BOOL userHasBoughtAds = [[BLDatabaseManager user] boughtRemoveAds];
    self.adBanner.hidden = userHasBoughtAds;
    
    if (!userHasBoughtAds) {
        NSInteger bottomInset = [BLController isIpad] ? 90 : 50;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomInset, 0);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.levels.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.layoutMargins = UIEdgeInsetsZero;
    
    UILabel *level = (UILabel* )[cell viewWithTag:1];
    UIProgressView *progress = (UIProgressView* )[cell viewWithTag:2];
    UILabel *score = (UILabel* )[cell viewWithTag:3];
    UIImageView *locker = (UIImageView* )[cell viewWithTag:4];
    
    NSInteger levelIndex = indexPath.row + 1;
    level.text = [NSString stringWithFormat:@"Nível %ld", levelIndex];
    
    
    if ([BLGameManager canPlayLevel:levelIndex]) {
        
        double correctLogos = [BLDatabaseManager correctLogosForLevel:levelIndex];
        float progressn = correctLogos / kMaximumLogoPerLevel;
        [progress setProgress:progressn animated:NO];
        progress.hidden = NO;
        
        score.text = [NSString stringWithFormat:@"%d / %d", (int)correctLogos, kMaximumLogoPerLevel];
        score.hidden = NO;
        
        locker.hidden = YES;
    } else {
        
        progress.hidden = YES;
        score.hidden = YES;
        locker.hidden = NO;
    }
    

    
    return cell;
}

- (double)progressForLevel:(NSInteger)levelIndex {
    
    NSInteger correctLogos = [BLDatabaseManager correctLogosForLevel:levelIndex];
    
    return correctLogos / kMaximumLogoPerLevel;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    NSInteger index = [[self.tableView indexPathForSelectedRow] row];
    
    if ([BLGameManager canPlayLevel:index + 1]) {
        return YES;
    } else {
        NSInteger logos = [BLGameManager logosToNextLevel:index + 1];
        NSString *message = [NSString stringWithFormat:@"Voce precisa acertar mais %ld %@ para jogar este nível.", logos, logos > 1 ? @"logos" : @"logo"];
        [self.view makeToast:message position:[self getPoint] color:kColorDarkGreen];
        
        return NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSInteger index = [[self.tableView indexPathForSelectedRow] row];
    
    BLLevelViewController *levelVC = [segue destinationViewController];
    levelVC.levelID = index + 1;
    levelVC.logos = self.levels[index];
}

- (NSValue*)getPoint {
    
    CGSize size = self.view.bounds.size;
    CGFloat height = (size.height / 100) * 65;
    CGPoint point = CGPointMake(size.width / 2,  height);
    NSValue *value = [NSValue valueWithCGPoint:point];
    
    return value;
}

#pragma mark - BLBannerManagerDelegate

- (void)loadBanner {
    
    [[BLBannerManager shared] resetAdView:self];
}

- (void)bannerWillAppear:(UIView *)banner {
    
    if (![self.adBanner.subviews containsObject:banner]) {
        [self.adBanner addSubview:banner];
    }
}

- (void)bannerWillDisappear:(UIView *)banner {
    
    [banner removeFromSuperview];
}

#pragma mark - InAppDelegate

- (void)refreshUI {
    
    [self updateCoins];
    self.heigthAdBannerConstraint.constant = [[BLDatabaseManager user] boughtRemoveAds] ? 0 : [BLController isIpad] ? 90 : 50;
    [self.view layoutIfNeeded];
}

@end
