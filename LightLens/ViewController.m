//
//  ViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-21.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//@synthesize request = _request;

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
    [_web setDelegate:self];
    // Do any additional setup after loading the view.
    [_web loadRequest:_request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [_loading setHidden:NO];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_loading setHidden:YES];
}

- (IBAction)share:(id)sender {
    NSURL *urlShare = self.url;
    NSArray *itemToShare = @[urlShare];
    UIActivityViewController *activityCV = [[UIActivityViewController alloc] initWithActivityItems:itemToShare applicationActivities:nil];
    [self presentViewController:activityCV animated:YES completion:nil];
}
@end
