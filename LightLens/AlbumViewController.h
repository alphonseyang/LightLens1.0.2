//
//  AlbumViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-30.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import <Parse/Parse.h>

@interface AlbumViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *pageImages;
- (IBAction)imageAction:(id)sender;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *num;

@end
