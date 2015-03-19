//
//  followViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-28.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "followViewController.h"

@interface followViewController ()

@end

@implementation followViewController

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
    // Do any additional setup after loading the view.
    
    self.follow.text = @"WeChat：LightLens光轨\nWeibo：@LightLens光轨";
    
}


@end
