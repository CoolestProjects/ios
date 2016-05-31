//
//  ViewController.m
//  CoolestProjects
//
//  Created by BooRanger on 28/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "ViewController.h"
#import "CPAFirebaseDefaultService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    id<CPAFirebaseService> firebaseService = [CPAFirebaseDefaultService new];
    
    [firebaseService getSpeakersWithCompletionBlock:^(NSArray *speakers, NSError *error) {
        NSLog(@"speakers %@", speakers);
    }];

    [firebaseService getSummitsWithCompletionBlock:^(NSArray *summits, NSError *error) {
        NSLog(@"summits %@", summits);
    }];
    
    [firebaseService getSponsorsWithCompletionBlock:^(NSArray *sponsors, NSError *error) {
        NSLog(@"sponsors %@", sponsors);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
