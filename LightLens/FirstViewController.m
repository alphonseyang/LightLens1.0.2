//
//  FirstViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-20.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    sleep(2);
    self.image.image = [UIImage imageNamed:@"lightlens-profile.jpg"];
    self.label.text = @"即使是一道最微弱的光\n我们也要将它洒向生活";
}

- (IBAction)share:(id)sender {
    NSString *label1Text = self.label.text;
    NSString *label2Text = self.label2.text;
    UIImage *image = self.image.image;
    NSArray *itemToShare = @[label1Text, label2Text, image];  //create a array contains the thing that will be shared
    UIActivityViewController *activityCV = [[UIActivityViewController alloc] initWithActivityItems:itemToShare applicationActivities:nil];
    [self presentViewController:activityCV animated:YES completion:nil];  //show the activity view
    
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:  (NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:3.0]; // Used For Showing Splash Screen for More Time
    return YES;
}

@end
