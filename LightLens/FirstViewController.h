//
//  FirstViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-20.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface FirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)share:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label2;

@end
