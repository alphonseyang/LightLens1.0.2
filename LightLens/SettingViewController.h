//
//  SettingViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-27.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingViewController : UIViewController
- (IBAction)clearCache:(id)sender;
- (IBAction)reportIssue:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *cacheLabel;
- (IBAction)toAppStore:(id)sender;

@end
