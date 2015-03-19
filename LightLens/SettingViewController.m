//
//  SettingViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-27.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)clearCache:(id)sender {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finished" message:@"Cache is cleared" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)reportIssue:(id)sender {
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:(id<MFMailComposeViewControllerDelegate>)self];
    if([MFMailComposeViewController canSendMail]){
        [composer setToRecipients:[NSArray arrayWithObjects:@"lightlens@163.com", @"alphonseyang@live.com", nil]];
        [composer setSubject:@"Issure Report"];
        [composer setMessageBody:@"Hello，LightLens, I find there's some problem in this app (enter the problem)）" isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];  //present mail view
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The mail cannot be sent!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There's an error in sending Email" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];  //this line will dismiss the sending view if the re's an error in the sending part
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"Thank you for informing us, we will solve this problem as soon as possible" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];  //this line will dismiss the sending view if the sending part is finished
    }
}


- (IBAction)toAppStore:(id)sender {
    NSString *urlStr = @"http://appstore.com/LightLens";
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}



@end
