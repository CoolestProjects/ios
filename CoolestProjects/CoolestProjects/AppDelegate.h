//
//  AppDelegate.h
//  CoolestProjects
//
//  Created by BooRanger on 28/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) ESTBeaconManager *beaconManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 3. Set up your Estimote Cloud credentials
    [ESTConfig setupAppID:@"coolest-projects-782" andAppToken:@"bc1d0eea387420e59c6480bd3c7ee1b4"];
    
    // 4. Enable analytics
    [ESTConfig enableRangingAnalytics:YES];
    [ESTConfig enableMonitoringAnalytics:YES];
    
    // 5. Instantiate the beacon manager
    self.beaconManager = [ESTBeaconManager new];
    
    // 6. Start scanning for beacons
    [self.beaconManager startRangingBeaconsInRegion:
     [[CLBeaconRegion alloc] initWithProximityUUID:@"0B691DC7-DC66-4C12-B197-CC8F56735C0C"
                                        identifier:@"cp beacons"]];
