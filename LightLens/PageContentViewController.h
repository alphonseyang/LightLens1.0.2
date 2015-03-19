//
//  PageContentViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-30.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property UIImage *imageFile;

@end
