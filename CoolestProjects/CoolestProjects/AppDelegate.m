//
//  AppDelegate.m
//  CoolestProjects
//
//  Created by BooRanger on 28/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import <Firebase/Firebase.h>
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"
#import "CPAFirebaseDefaultService.h"
#import "Coolest_Projects-Swift.h"


@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) BeaconNotificationsManager *beaconNotificationManager;
@property (nonatomic, strong) id<CPAFirebaseService> firebaseService;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupFirebase];

    [self preloadContent];

    [self createBeaconManager];

    [self setupNotifications];

    [self setupAppearance];

//    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(fireTestStageNotification) userInfo:nil repeats:NO];
    return YES;
}

- (void)fireTestStageNotification {
    [self processNotificationDeeplinkUserInfo:@{@"deeplink_page":@"stages", @"deeplink_identifier": @"Paul Downey", @"deeplink_stage":@"Mastercard Code"}];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    BOOL isAuthorizedForMonitoring = self.beaconNotificationManager.isAuthorizedForMonitoring;
    BOOL deviceSupportsBLE = self.beaconNotificationManager.deviceSupportsBLE;
    BOOL isBLEPoweredOff = self.beaconNotificationManager.isBLEPoweredOff;
    if (deviceSupportsBLE && isAuthorizedForMonitoring && isBLEPoweredOff) {
        [BluetoothAlertManager.sharedInstance showBluetoothPowerOffAlert];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[FIRInstanceID instanceID] setAPNSToken:deviceToken type:FIRInstanceIDAPNSTokenTypeUnknown];
}

- (void)setupFirebase {
    [FIRApp configure];
    [[FIRDatabase database] setPersistenceEnabled:YES];
    self.firebaseService = [CPAFirebaseDefaultService new];
}

- (void)setupNotifications {
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert|UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  [[UIApplication sharedApplication] registerForRemoteNotifications];
                              }
                          }];
}

- (void)createBeaconManager {
    self.beaconNotificationManager = BeaconNotificationsManager.sharedInstance;
}

- (void)preloadContent {
    [self.firebaseService getSpeakersWithCompletionBlock:nil];
    [self.firebaseService getSummitsWithCompletionBlock:nil];
    [self.firebaseService getSponsorsWithCompletionBlock:nil];
    [self.firebaseService getAboutInfoWithCompletionBlock:nil];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    // nothing to do here, just tell iOS to display the notification
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler {
    if ([response.actionIdentifier isEqualToString:UNNotificationDefaultActionIdentifier]) {
        // The user launched the app.
        if(response.notification.request.content.userInfo[@"deeplink_page"]) {
            [self processNotificationDeeplinkUserInfo:response.notification.request.content.userInfo];
        }
    }
    completionHandler();
}

- (void)processNotificationDeeplinkUserInfo:(NSDictionary *)userInfo {
    [CPADeeplinkManager handleDeeplinkWithUserInfo:userInfo rootViewController:self.window.rootViewController];
}

- (void)setupAppearance {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    NSDictionary *navBarTitleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18.0]
    };
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation-bar-background-color"]
                                       forBarMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-indicator-image"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-indicator-image"]];

    UIBarButtonItem *navBarButtonAppearance = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]];

    NSDictionary *navBarButtonAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:14.0]
    };
    [navBarButtonAppearance setTitleTextAttributes:navBarButtonAttributes forState:UIControlStateNormal];
}

@end
