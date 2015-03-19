//
//  ViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-21.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) NSURLRequest *request;
@property (strong, nonatomic) IBOutlet UIWebView *web;
@property (strong, nonatomic) IBOutlet UILabel *loading;
@property (nonatomic, retain) NSURL *url;
- (IBAction)share:(id)sender;





@end
